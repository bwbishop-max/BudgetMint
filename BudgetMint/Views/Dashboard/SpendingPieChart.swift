import SwiftUI
import Charts

struct SpendingPieChart: View {
    let transactions: [Transaction]
    @State private var chartAppeared = false

    private var categoryTotals: [(category: BudgetCategory, amount: Double)] {
        let spending = transactions.filter { txn in
            txn.amount > 0 &&
            !txn.displayCategory.hasPrefix("TRANSFER") &&
            txn.displayCategory != "INCOME"
        }

        let grouped = Dictionary(grouping: spending) { $0.displayCategory }
        let all = grouped.map { key, txns in
            let total = txns.reduce(0) { $0 + $1.amount }
            return (category: BudgetCategory.forCategory(key), amount: total)
        }
        .sorted { $0.amount > $1.amount }

        // Top 7 + "Other" bucket
        if all.count > 8 {
            let top7 = Array(all.prefix(7))
            let otherTotal = all.dropFirst(7).reduce(0) { $0 + $1.amount }
            let otherCategory = BudgetCategory(id: "OTHER", displayName: "Other", icon: "ellipsis.circle.fill", color: .gray)
            return top7 + [(category: otherCategory, amount: otherTotal)]
        }
        return all
    }

    private var totalSpending: Double {
        categoryTotals.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack(spacing: BMTheme.spacingLG) {
            if categoryTotals.isEmpty {
                VStack(spacing: BMTheme.spacingMD) {
                    Image(systemName: "chart.pie")
                        .font(.system(size: 40))
                        .foregroundStyle(.secondary)
                    Text("No spending data")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Your spending breakdown will appear here once transactions are recorded.")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            } else {
                ZStack {
                    Chart(categoryTotals, id: \.category.id) { item in
                        SectorMark(
                            angle: .value("Amount", item.amount),
                            innerRadius: .ratio(0.6),
                            angularInset: 1.5
                        )
                        .foregroundStyle(item.category.color)
                        .cornerRadius(4)
                    }
                    .frame(height: 220)

                    // Center label
                    VStack(spacing: 2) {
                        Text("Total")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(totalSpending.currencyFormatted)
                            .font(.title3.bold())
                    }
                }
                .opacity(chartAppeared ? 1 : 0)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        chartAppeared = true
                    }
                }

                // Legend with percentages
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: BMTheme.spacingSM) {
                    ForEach(categoryTotals, id: \.category.id) { item in
                        HStack(spacing: 6) {
                            Circle()
                                .fill(item.category.color)
                                .frame(width: 8, height: 8)
                            Text(item.category.displayName)
                                .font(.caption)
                                .lineLimit(1)
                            Spacer()
                            Text(percentageText(for: item.amount))
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private func percentageText(for amount: Double) -> String {
        guard totalSpending > 0 else { return "0%" }
        let pct = (amount / totalSpending) * 100
        return String(format: "%.0f%%", pct)
    }
}
