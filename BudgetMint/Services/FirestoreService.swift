import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable
class FirestoreService {
    var accounts: [Account] = []
    var transactions: [Transaction] = []

    private let db = Firestore.firestore()
    private var accountsListener: ListenerRegistration?
    private var transactionsListener: ListenerRegistration?

    var totalNetWorth: Double {
        accounts.reduce(0) { total, account in
            let balance = account.balanceCurrent ?? 0
            // Credit cards and loans are liabilities (subtract)
            if account.type == "credit" || account.type == "loan" {
                return total - abs(balance)
            }
            return total + balance
        }
    }

    func startListening() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        // Listen to accounts
        accountsListener = db.collection("accounts")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self?.accounts = documents.compactMap { try? $0.data(as: Account.self) }
            }

        // Listen to transactions (most recent first, limit for performance)
        transactionsListener = db.collection("transactions")
            .whereField("userId", isEqualTo: userId)
            .order(by: "date", descending: true)
            .limit(to: 500)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self?.transactions = documents.compactMap { try? $0.data(as: Transaction.self) }
            }
    }

    func stopListening() {
        accountsListener?.remove()
        transactionsListener?.remove()
    }

    func updateTransactionCategory(_ transactionId: String, category: String) async throws {
        try await db.collection("transactions").document(transactionId).updateData([
            "userCategory": category
        ])
    }

    func updateTransactionNotes(_ transactionId: String, notes: String) async throws {
        try await db.collection("transactions").document(transactionId).updateData([
            "notes": notes
        ])
    }
}
