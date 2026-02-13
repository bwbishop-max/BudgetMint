import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    @Environment(FirestoreService.self) private var firestoreService
    @State private var editedNotes: String
    @State private var selectedCategory: String

    init(transaction: Transaction) {
        self.transaction = transaction
        _editedNotes = State(initialValue: transaction.notes)
        _selectedCategory = State(initialValue: transaction.displayCategory)
    }

    private var budgetCategory: BudgetCategory {
        BudgetCategory.forCategory(transaction.displayCategory)
    }

    var body: some View {
        List {
            // Header
            Section {
                VStack(spacing: BMTheme.spacingMD) {
                    // Merchant icon
                    if !transaction.logoUrl.isEmpty, let url = URL(string: transaction.logoUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        } placeholder: {
                            largeIcon
                        }
                    } else {
                        largeIcon
                    }

                    Text(transaction.merchantName.isEmpty ? transaction.name : transaction.merchantName)
                        .font(.title2.bold())

                    Text(transaction.amount, format: .currency(code: transaction.isoCurrencyCode.isEmpty ? "USD" : transaction.isoCurrencyCode))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(transaction.amount > 0 ? Color.primary : BMTheme.income)

                    if transaction.pending {
                        Text("Pending")
                            .font(.caption.weight(.medium))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(BMTheme.pending.opacity(0.2))
                            .foregroundStyle(BMTheme.pending)
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, BMTheme.spacingSM)
            }

            // Details
            Section("Details") {
                LabeledContent("Date") {
                    Text(transaction.parsedDate, style: .date)
                }
                LabeledContent("Payment Channel") {
                    Text(transaction.paymentChannel.capitalized)
                }
                if !transaction.website.isEmpty {
                    LabeledContent("Website") {
                        Text(transaction.website)
                            .foregroundStyle(BMTheme.brandGreen)
                    }
                }
                if !transaction.name.isEmpty && transaction.name != transaction.merchantName {
                    LabeledContent("Description") {
                        Text(transaction.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            // Category
            Section("Category") {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(BudgetCategory.all) { cat in
                        Label(cat.displayName, systemImage: cat.icon)
                            .tag(cat.id)
                    }
                }
                .pickerStyle(.navigationLink)
                .onChange(of: selectedCategory) { _, newValue in
                    guard newValue != transaction.displayCategory else { return }
                    guard let docId = transaction.id else { return }
                    Task {
                        try? await firestoreService.updateTransactionCategory(docId, category: newValue)
                    }
                }
            }

            // Notes
            Section("Notes") {
                TextField("Add a note...", text: $editedNotes, axis: .vertical)
                    .lineLimit(3...6)
                    .onChange(of: editedNotes) { _, newValue in
                        guard let docId = transaction.id else { return }
                        Task {
                            try? await firestoreService.updateTransactionNotes(docId, notes: newValue)
                        }
                    }
            }

            // Tags
            if !transaction.tags.isEmpty {
                Section("Tags") {
                    FlowLayout(spacing: BMTheme.spacingSM) {
                        ForEach(transaction.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption.weight(.medium))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color(.tertiarySystemFill))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var largeIcon: some View {
        Image(systemName: budgetCategory.icon)
            .font(.title)
            .foregroundStyle(budgetCategory.color)
            .frame(width: 64, height: 64)
            .background(budgetCategory.color.opacity(0.1))
            .clipShape(Circle())
    }
}

// Simple flow layout for tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = layout(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }

    private func layout(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }

        return (CGSize(width: maxWidth, height: y + rowHeight), positions)
    }
}
