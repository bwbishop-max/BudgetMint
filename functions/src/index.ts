import { onCall, onRequest, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { plaidClient } from "./plaid";
import { CountryCode, Products } from "plaid";

admin.initializeApp();
const db = admin.firestore();

// ---------- createLinkToken ----------
export const createLinkToken = onCall(async (request) => {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new HttpsError("unauthenticated", "User must be authenticated.");
  }

  const response = await plaidClient.linkTokenCreate({
    user: { client_user_id: uid },
    client_name: "BudgetMint",
    products: [Products.Transactions],
    country_codes: [CountryCode.Us],
    language: "en",
  });

  return { link_token: response.data.link_token };
});

// ---------- exchangePublicToken ----------
export const exchangePublicToken = onCall(async (request) => {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new HttpsError("unauthenticated", "User must be authenticated.");
  }

  const publicToken = request.data?.publicToken;
  if (!publicToken) {
    throw new HttpsError("invalid-argument", "publicToken is required.");
  }

  const exchangeResponse = await plaidClient.itemPublicTokenExchange({
    public_token: publicToken,
  });

  const accessToken = exchangeResponse.data.access_token;
  const itemId = exchangeResponse.data.item_id;

  await db.doc(`plaid_items/${itemId}`).set({
    userId: uid,
    accessToken,
    itemId,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    transactionsCursor: null,
  });

  const accountsResponse = await plaidClient.accountsGet({
    access_token: accessToken,
  });

  const batch = db.batch();
  for (const account of accountsResponse.data.accounts) {
    const ref = db.doc(`accounts/${account.account_id}`);
    batch.set(ref, {
      userId: uid,
      itemId,
      plaidAccountId: account.account_id,
      name: account.name,
      officialName: account.official_name ?? null,
      type: account.type,
      subtype: account.subtype ?? null,
      balanceCurrent: account.balances.current ?? null,
      balanceAvailable: account.balances.available ?? null,
      mask: account.mask ?? null,
      institutionId: accountsResponse.data.item.institution_id ?? null,
    });
  }
  await batch.commit();

  return { success: true, itemId };
});

// ---------- syncTransactions ----------
export const syncTransactions = onCall(async (request) => {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new HttpsError("unauthenticated", "User must be authenticated.");
  }

  const itemId = request.data?.itemId;
  if (!itemId) {
    throw new HttpsError("invalid-argument", "itemId is required.");
  }

  const itemDoc = await db.doc(`plaid_items/${itemId}`).get();
  if (!itemDoc.exists || itemDoc.data()?.userId !== uid) {
    throw new HttpsError("permission-denied", "Item not found or access denied.");
  }

  const itemData = itemDoc.data()!;
  const accessToken = itemData.accessToken;
  let cursor: string | undefined = itemData.transactionsCursor ?? undefined;

  let addedCount = 0;
  let modifiedCount = 0;
  let removedCount = 0;
  let hasMore = true;

  while (hasMore) {
    const response = await plaidClient.transactionsSync({
      access_token: accessToken,
      cursor,
      options: { include_personal_finance_category: true },
    });

    const { added, modified, removed, next_cursor, has_more } = response.data;

    // Process in batches of 500 (Firestore limit)
    const allOps: Array<{ type: "set" | "update" | "delete"; ref: FirebaseFirestore.DocumentReference; data?: Record<string, unknown> }> = [];

    for (const txn of added) {
      const pfc = txn.personal_finance_category;
      allOps.push({
        type: "set",
        ref: db.doc(`transactions/${txn.transaction_id}`),
        data: {
          userId: uid,
          accountId: txn.account_id,
          transactionId: txn.transaction_id,
          amount: txn.amount,
          date: txn.date,
          merchantName: txn.merchant_name ?? null,
          name: txn.name,
          category: pfc?.primary ?? null,
          categoryDetailed: pfc?.detailed ?? null,
          categoryConfidence: pfc?.confidence_level ?? null,
          categoryIconUrl: txn.personal_finance_category_icon_url ?? null,
          paymentChannel: txn.payment_channel,
          pending: txn.pending,
          logoUrl: txn.logo_url ?? null,
          website: txn.website ?? null,
          isoCurrencyCode: txn.iso_currency_code ?? null,
          userCategory: null,
          tags: [],
          notes: "",
        },
      });
    }

    for (const txn of modified) {
      allOps.push({
        type: "update",
        ref: db.doc(`transactions/${txn.transaction_id}`),
        data: {
          amount: txn.amount,
          date: txn.date,
          pending: txn.pending,
          merchantName: txn.merchant_name ?? null,
        },
      });
    }

    for (const txn of removed) {
      allOps.push({
        type: "delete",
        ref: db.doc(`transactions/${txn.transaction_id}`),
      });
    }

    // Write in batches of 500
    for (let i = 0; i < allOps.length; i += 500) {
      const batch = db.batch();
      const slice = allOps.slice(i, i + 500);
      for (const op of slice) {
        if (op.type === "set") {
          batch.set(op.ref, op.data!);
        } else if (op.type === "update") {
          batch.update(op.ref, op.data!);
        } else {
          batch.delete(op.ref);
        }
      }
      await batch.commit();
    }

    addedCount += added.length;
    modifiedCount += modified.length;
    removedCount += removed.length;
    cursor = next_cursor;
    hasMore = has_more;
  }

  await db.doc(`plaid_items/${itemId}`).update({
    transactionsCursor: cursor,
    lastSyncedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { added: addedCount, modified: modifiedCount, removed: removedCount };
});

// ---------- refreshBalances ----------
export const refreshBalances = onCall(async (request) => {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new HttpsError("unauthenticated", "User must be authenticated.");
  }

  const itemId = request.data?.itemId;
  if (!itemId) {
    throw new HttpsError("invalid-argument", "itemId is required.");
  }

  const itemDoc = await db.doc(`plaid_items/${itemId}`).get();
  if (!itemDoc.exists || itemDoc.data()?.userId !== uid) {
    throw new HttpsError("permission-denied", "Item not found or access denied.");
  }

  const accessToken = itemDoc.data()!.accessToken;

  const balancesResponse = await plaidClient.accountsBalanceGet({
    access_token: accessToken,
  });

  const accounts = balancesResponse.data.accounts;
  const batch = db.batch();
  for (const account of accounts) {
    const ref = db.doc(`accounts/${account.account_id}`);
    batch.update(ref, {
      balanceCurrent: account.balances.current ?? null,
      balanceAvailable: account.balances.available ?? null,
      lastBalanceUpdate: admin.firestore.FieldValue.serverTimestamp(),
    });
  }
  await batch.commit();

  return { accounts: accounts.length };
});

// ---------- plaidWebhook ----------
export const plaidWebhook = onRequest(async (req, res) => {
  if (req.method !== "POST") {
    res.status(405).send({ error: "Method not allowed" });
    return;
  }

  const { webhook_type, webhook_code, item_id } = req.body;

  if (webhook_type === "TRANSACTIONS" && webhook_code === "SYNC_UPDATES_AVAILABLE") {
    console.log(`Transaction sync update available for item: ${item_id}`);
  }

  res.status(200).send({ received: true });
});
