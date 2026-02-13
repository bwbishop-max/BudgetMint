import SwiftUI

struct TransactionListView: View {
    @Environment(FirestoreService.self) private var firestoreService
    @State private var searchText = ""
    @State private var selectedCategory: String?

    private var filteredTransactions: [Transaction] {
        var txns = firestoreService.transactions

        if !searchText.isEmpty {
            txns = txns.filter { txn in
                txn.merchantName.localizedCaseInsensitiveContains(searchText) ||
                txn.name.localizedCaseInsensitiveContains(searchText) ||
                txn.notes.localizedCaseInsensitiveContains(searchText)
            }
        }

        if let category = selectedCategory {
            txns = txns.filter { $0.displayCategory == category }
        }

        return txns
    }

    private var groupedByDate: [(String, [Transaction])] {
        let grouped = Dictionary(grouping: filteredTransactions) { $0.date }
        return grouped.sorted { $0.key > $1.key }
    }

    private var activeCategories: [BudgetCategory] {
        let categoryIds = Set(firestoreService.transactions.map { $0.displayCategory })
        return categoryIds.map { BudgetCategory.forCategory($0) }.sorted { $0.displayName < $1.displayName }
    }

    var body: some View {
        NavigationStack {
            List {
                // Category filter chips
                if !activeCategories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            FilterChip(title: "All", isSelected: selectedCategory == nil) {
                                selectedCategory = nil
                            }
                            ForEach(activeCategories) { cat in
                                FilterChip(
                                    title: cat.displayName,
                                    color: cat.color,
                                    isSelected: selectedCategory == cat.id
                                ) {
                                    selectedCategory = selectedCategory == cat.id ? nil : cat.id
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .listRowSeparator(.hidden)
                }

                // Transactions grouped by date
                ForEach(groupedByDate, id: \.0) { date, transactions in
                    Section(header: Text(date.toDate?.shortFormatted ?? date)) {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                }

                if filteredTransactions.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Transactions")
            .searchable(text: $searchText, prompt: "Search transactions")
            .refreshable {
                await syncAllItems()
            }
        }
    }

    private func syncAllItems() async {
        let plaidService = PlaidService()
        let itemIds = Set(firestoreService.accounts.map { $0.itemId })
        for itemId in itemIds {
            _ = try? await plaidService.syncTransactions(itemId: itemId)
        }
    }
}

struct FilterChip: View {
    let title: String
    var color: Color = .primary
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? color.opacity(0.2) : Color.gray.opacity(0.15))
                .foregroundStyle(isSelected ? color : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
