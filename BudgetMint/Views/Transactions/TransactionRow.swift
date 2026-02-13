import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    private var budgetCategory: BudgetCategory {
        BudgetCategory.forCategory(transaction.displayCategory)
    }

    var body: some View {
        HStack(spacing: 12) {
            // Merchant logo or category icon
            if !transaction.logoUrl.isEmpty, let url = URL(string: transaction.logoUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .transition(.opacity)
                } placeholder: {
                    categoryIcon
                }
            } else {
                categoryIcon
            }

            // Merchant name and date
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.merchantName.isEmpty ? transaction.name : transaction.merchantName)
                    .font(.body.weight(.medium))
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Text(transaction.parsedDate, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if transaction.pending {
                        Text("Pending")
                            .font(.caption2.weight(.medium))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 1)
                            .background(BMTheme.pending.opacity(0.2))
                            .foregroundStyle(BMTheme.pending)
                            .clipShape(Capsule())
                    }
                }
            }

            Spacer()

            // Amount and category
            VStack(alignment: .trailing, spacing: 2) {
                Text(transaction.amount, format: .currency(code: transaction.isoCurrencyCode.isEmpty ? "USD" : transaction.isoCurrencyCode))
                    .font(.body.weight(.semibold))
                    .foregroundStyle(transaction.amount > 0 ? Color.primary : BMTheme.income)

                Text(budgetCategory.displayName)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 1)
                    .background(budgetCategory.color.opacity(0.15))
                    .foregroundStyle(budgetCategory.color)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, BMTheme.spacingSM)
    }

    private var categoryIcon: some View {
        Image(systemName: budgetCategory.icon)
            .font(.title3)
            .foregroundStyle(budgetCategory.color)
            .frame(width: 40, height: 40)
            .background(budgetCategory.color.opacity(0.1))
            .clipShape(Circle())
    }
}
