import SwiftUI

struct AccountDetailView: View {
    let account: Account
    @Environment(FirestoreService.self) private var firestoreService

    private var typeColor: Color {
        BMTheme.colorForAccountType(account.type)
    }

    private var accountTransactions: [Transaction] {
        firestoreService.transactions.filter { $0.accountId == account.plaidAccountId }
    }

    private var groupedByDate: [(String, [Transaction])] {
        let grouped = Dictionary(grouping: accountTransactions) { $0.date }
        return grouped.sorted { $0.key > $1.key }
    }

    var body: some View {
        List {
            // Header
            Section {
                VStack(spacing: BMTheme.spacingMD) {
                    Image(systemName: BMTheme.iconForAccountType(account.type))
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 64, height: 64)
                        .background(typeColor)
                        .clipShape(Circle())

                    Text(account.name)
                        .font(.title2.bold())

                    if let mask = account.mask {
                        Text("••••\(mask)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Text((account.balanceCurrent ?? 0).currencyFormatted)
                        .font(.system(size: 32, weight: .bold, design: .rounded))

                    if let available = account.balanceAvailable {
                        Text("\(available.currencyFormatted) available")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, BMTheme.spacingSM)
            }

            // Account Info
            Section("Account Info") {
                LabeledContent("Type") {
                    Text(account.type.capitalized)
                }
                if let subtype = account.subtype {
                    LabeledContent("Subtype") {
                        Text(subtype.capitalized)
                    }
                }
                if let officialName = account.officialName, !officialName.isEmpty {
                    LabeledContent("Official Name") {
                        Text(officialName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                if let lastUpdate = account.lastBalanceUpdate {
                    LabeledContent("Last Updated") {
                        Text(lastUpdate, style: .relative)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            // Transactions for this account
            if !accountTransactions.isEmpty {
                ForEach(groupedByDate, id: \.0) { date, transactions in
                    Section(header: Text(date.toDate?.shortFormatted ?? date)) {
                        ForEach(transactions) { transaction in
                            NavigationLink(value: transaction) {
                                TransactionRow(transaction: transaction)
                            }
                        }
                    }
                }
            } else {
                Section("Transactions") {
                    ContentUnavailableView(
                        "No Transactions",
                        systemImage: "list.bullet.rectangle",
                        description: Text("No transactions found for this account.")
                    )
                }
            }
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Transaction.self) { transaction in
            TransactionDetailView(transaction: transaction)
        }
    }
}
