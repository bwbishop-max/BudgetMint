import SwiftUI

struct DashboardView: View {
    @Environment(FirestoreService.self) private var firestoreService
    @State private var isRefreshing = false

    private var currentMonthTransactions: [Transaction] {
        let calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        let prefix = String(format: "%04d-%02d", year, month)
        return firestoreService.transactions.filter { $0.date.hasPrefix(prefix) }
    }

    private var totalSpendingThisMonth: Double {
        currentMonthTransactions
            .filter { $0.amount > 0 && !$0.displayCategory.hasPrefix("TRANSFER") && $0.displayCategory != "INCOME" }
            .reduce(0) { $0 + $1.amount }
    }

    private var totalIncomeThisMonth: Double {
        currentMonthTransactions
            .filter { $0.amount < 0 || $0.displayCategory == "INCOME" }
            .reduce(0) { $0 + abs($1.amount) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Net Worth Card
                    VStack(spacing: 8) {
                        Text("Net Worth")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(firestoreService.totalNetWorth.currencyFormatted)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(firestoreService.totalNetWorth >= 0 ? .primary : .red)
                        Text("\(firestoreService.accounts.count) linked account\(firestoreService.accounts.count == 1 ? "" : "s")")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    // Monthly Summary
                    HStack(spacing: 16) {
                        SummaryCard(title: "Income", amount: totalIncomeThisMonth, color: .green, icon: "arrow.down.circle.fill")
                        SummaryCard(title: "Spending", amount: totalSpendingThisMonth, color: .red, icon: "arrow.up.circle.fill")
                    }
                    .padding(.horizontal)

                    // Spending Breakdown Chart
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Spending by Category")
                            .font(.headline)
                            .padding(.horizontal)

                        SpendingPieChart(transactions: currentMonthTransactions)
                            .padding(.horizontal)
                    }

                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Recent Transactions")
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.horizontal)

                        if firestoreService.transactions.isEmpty {
                            Text("No transactions yet. Link a bank account to get started.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)
                                .padding(.vertical, 20)
                        } else {
                            VStack(spacing: 0) {
                                ForEach(firestoreService.transactions.prefix(5)) { transaction in
                                    TransactionRow(transaction: transaction)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                    if transaction.id != firestoreService.transactions.prefix(5).last?.id {
                                        Divider()
                                            .padding(.leading, 52)
                                    }
                                }
                            }
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Dashboard")
            .refreshable {
                await refreshAll()
            }
        }
    }

    private func refreshAll() async {
        let plaidService = PlaidService()
        let itemIds = Set(firestoreService.accounts.map { $0.itemId })
        for itemId in itemIds {
            _ = try? await plaidService.refreshBalances(itemId: itemId)
            _ = try? await plaidService.syncTransactions(itemId: itemId)
        }
    }
}

struct SummaryCard: View {
    let title: String
    let amount: Double
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(amount.currencyFormatted)
                .font(.title3.bold())
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
