import SwiftUI
import Charts

struct SpendingPieChart: View {
    let transactions: [Transaction]

    private var categoryTotals: [(category: BudgetCategory, amount: Double)] {
        // Only count spending (positive amounts), exclude transfers and income
        let spending = transactions.filter { txn in
            txn.amount > 0 &&
            !txn.displayCategory.hasPrefix("TRANSFER") &&
            txn.displayCategory != "INCOME"
        }

        let grouped = Dictionary(grouping: spending) { $0.displayCategory }
        return grouped.map { key, txns in
            let total = txns.reduce(0) { $0 + $1.amount }
            return (category: BudgetCategory.forCategory(key), amount: total)
        }
        .sorted { $0.amount > $1.amount }
    }

    private var totalSpending: Double {
        categoryTotals.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack(spacing: 16) {
            if categoryTotals.isEmpty {
                Text("No spending data")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(height: 200)
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

                // Legend
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                    ForEach(categoryTotals.prefix(8), id: \.category.id) { item in
                        HStack(spacing: 6) {
                            Circle()
                                .fill(item.category.color)
                                .frame(width: 8, height: 8)
                            Text(item.category.displayName)
                                .font(.caption)
                                .lineLimit(1)
                            Spacer()
                            Text(item.amount.currencyFormatted)
                                .font(.caption.weight(.medium))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
