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

    private var lastMonthTransactions: [Transaction] {
        let calendar = Calendar.current
        let now = Date()
        guard let lastMonth = calendar.date(byAdding: .month, value: -1, to: now) else { return [] }
        let year = calendar.component(.year, from: lastMonth)
        let month = calendar.component(.month, from: lastMonth)
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

    private var lastMonthSpending: Double {
        lastMonthTransactions
            .filter { $0.amount > 0 && !$0.displayCategory.hasPrefix("TRANSFER") && $0.displayCategory != "INCOME" }
            .reduce(0) { $0 + $1.amount }
    }

    private var monthOverMonthChange: Double? {
        guard lastMonthSpending > 0 else { return nil }
        return ((totalSpendingThisMonth - lastMonthSpending) / lastMonthSpending) * 100
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: BMTheme.spacingXXL) {
                    if firestoreService.accounts.isEmpty {
                        // Empty onboarding state
                        VStack(spacing: BMTheme.spacingLG) {
                            Image(systemName: "building.columns.circle.fill")
                                .font(.system(size: 56))
                                .foregroundStyle(BMTheme.brandGreen)
                            Text("Welcome to BudgetMint")
                                .font(.title2.bold())
                            Text("Link your first bank account to start tracking your spending and net worth.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .bmCard()
                        .padding(.horizontal)
                    } else {
                        // Net Worth Card with gradient
                        VStack(spacing: BMTheme.spacingSM) {
                            Text("Net Worth")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.white.opacity(0.85))
                            Text(firestoreService.totalNetWorth.currencyFormatted)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            Text("\(firestoreService.accounts.count) linked account\(firestoreService.accounts.count == 1 ? "" : "s")")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, BMTheme.spacingXXL)
                        .background(BMTheme.brandGreenGradient)
                        .clipShape(RoundedRectangle(cornerRadius: BMTheme.cornerLG))
                        .shadow(color: .black.opacity(BMTheme.cardShadowOpacity), radius: BMTheme.cardShadowRadius, y: BMTheme.cardShadowY)
                        .padding(.horizontal)

                        // Monthly Summary
                        HStack(spacing: BMTheme.spacingLG) {
                            SummaryCard(title: "Income", amount: totalIncomeThisMonth, color: BMTheme.income, icon: "arrow.down.circle.fill")
                            SummaryCard(title: "Spending", amount: totalSpendingThisMonth, color: BMTheme.expense, icon: "arrow.up.circle.fill")
                        }
                        .padding(.horizontal)

                        // Month-over-month insight
                        if let change = monthOverMonthChange {
                            HStack(spacing: BMTheme.spacingSM) {
                                Image(systemName: change > 0 ? "arrow.up.right" : "arrow.down.right")
                                    .foregroundStyle(change > 0 ? BMTheme.expense : BMTheme.income)
                                Text(String(format: "%.0f%% %@ than last month", abs(change), change > 0 ? "more" : "less"))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal)
                        }

                        // Spending Breakdown Chart
                        VStack(alignment: .leading, spacing: BMTheme.spacingMD) {
                            Text("Spending by Category")
                                .font(.headline)
                                .padding(.horizontal)

                            SpendingPieChart(transactions: currentMonthTransactions)
                                .padding(.horizontal)
                        }

                        // Recent Transactions
                        VStack(alignment: .leading, spacing: BMTheme.spacingMD) {
                            HStack {
                                Text("Recent Transactions")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding(.horizontal)

                            if firestoreService.transactions.isEmpty {
                                VStack(spacing: BMTheme.spacingMD) {
                                    Image(systemName: "list.bullet.rectangle")
                                        .font(.title)
                                        .foregroundStyle(.secondary)
                                    Text("No transactions yet. Link a bank account to get started.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .bmCard()
                                .padding(.horizontal)
                            } else {
                                VStack(spacing: 0) {
                                    ForEach(firestoreService.transactions.prefix(5)) { transaction in
                                        NavigationLink(value: transaction) {
                                            TransactionRow(transaction: transaction)
                                                .padding(.horizontal)
                                                .padding(.vertical, BMTheme.spacingSM)
                                        }
                                        .buttonStyle(.plain)
                                        if transaction.id != firestoreService.transactions.prefix(5).last?.id {
                                            Divider()
                                                .padding(.leading, 52)
                                        }
                                    }
                                }
                                .bmCard()
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Dashboard")
            .refreshable {
                await refreshAll()
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            .navigationDestination(for: Transaction.self) { transaction in
                TransactionDetailView(transaction: transaction)
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
        VStack(spacing: BMTheme.spacingSM) {
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
        .bmCard()
    }
}
