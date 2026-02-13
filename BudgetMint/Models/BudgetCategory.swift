import SwiftUI

struct BudgetCategory: Identifiable {
    let id: String            // Plaid PFC primary key (e.g. "FOOD_AND_DRINK")
    let displayName: String
    let icon: String          // SF Symbol name
    let color: Color

    static let all: [BudgetCategory] = [
        BudgetCategory(id: "INCOME", displayName: "Income", icon: "dollarsign.circle.fill", color: .green),
        BudgetCategory(id: "TRANSFER_IN", displayName: "Transfer In", icon: "arrow.down.circle.fill", color: .blue),
        BudgetCategory(id: "TRANSFER_OUT", displayName: "Transfer Out", icon: "arrow.up.circle.fill", color: .blue),
        BudgetCategory(id: "LOAN_PAYMENTS", displayName: "Loan Payments", icon: "banknote.fill", color: .orange),
        BudgetCategory(id: "BANK_FEES", displayName: "Bank Fees", icon: "building.columns.fill", color: .red),
        BudgetCategory(id: "ENTERTAINMENT", displayName: "Entertainment", icon: "film.fill", color: .purple),
        BudgetCategory(id: "FOOD_AND_DRINK", displayName: "Food & Drink", icon: "fork.knife", color: .orange),
        BudgetCategory(id: "GENERAL_MERCHANDISE", displayName: "Shopping", icon: "cart.fill", color: .pink),
        BudgetCategory(id: "HOME_IMPROVEMENT", displayName: "Home", icon: "house.fill", color: .brown),
        BudgetCategory(id: "MEDICAL", displayName: "Medical", icon: "cross.case.fill", color: .red),
        BudgetCategory(id: "PERSONAL_CARE", displayName: "Personal Care", icon: "figure.walk", color: .teal),
        BudgetCategory(id: "GENERAL_SERVICES", displayName: "Services", icon: "wrench.and.screwdriver.fill", color: .gray),
        BudgetCategory(id: "GOVERNMENT_AND_NON_PROFIT", displayName: "Government", icon: "building.2.fill", color: .indigo),
        BudgetCategory(id: "TRANSPORTATION", displayName: "Transportation", icon: "car.fill", color: .cyan),
        BudgetCategory(id: "TRAVEL", displayName: "Travel", icon: "airplane", color: .mint),
        BudgetCategory(id: "RENT_AND_UTILITIES", displayName: "Rent & Utilities", icon: "bolt.fill", color: .yellow),
    ]

    static let categoryMap: [String: BudgetCategory] = {
        Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })
    }()

    static func forCategory(_ id: String) -> BudgetCategory {
        categoryMap[id] ?? BudgetCategory(id: id, displayName: id.replacingOccurrences(of: "_", with: " ").capitalized, icon: "questionmark.circle.fill", color: .gray)
    }
}
