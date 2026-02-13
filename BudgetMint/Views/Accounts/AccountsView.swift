import SwiftUI

struct AccountsView: View {
    @Environment(FirestoreService.self) private var firestoreService
    @State private var showingLinkAccount = false

    private var groupedAccounts: [String: [Account]] {
        Dictionary(grouping: firestoreService.accounts) { $0.type }
    }

    private var sortedAccountTypes: [String] {
        let order = ["depository", "credit", "loan", "investment", "other"]
        return groupedAccounts.keys.sorted { a, b in
            (order.firstIndex(of: a) ?? 99) < (order.firstIndex(of: b) ?? 99)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                // Net worth summary
                Section {
                    HStack {
                        Text("Net Worth")
                            .font(.headline)
                        Spacer()
                        Text(firestoreService.totalNetWorth.currencyFormatted)
                            .font(.title2.bold())
                            .foregroundStyle(firestoreService.totalNetWorth >= 0 ? BMTheme.brandGreen : .red)
                    }
                    .padding(.vertical, 4)
                }

                // Accounts grouped by type
                ForEach(sortedAccountTypes, id: \.self) { type in
                    Section(header: Label(displayName(for: type), systemImage: BMTheme.iconForAccountType(type))) {
                        ForEach(groupedAccounts[type] ?? []) { account in
                            NavigationLink(value: account) {
                                AccountRow(account: account)
                            }
                        }
                    }
                }

                if firestoreService.accounts.isEmpty {
                    Section {
                        ContentUnavailableView(
                            "No Accounts Linked",
                            systemImage: "building.columns",
                            description: Text("Link your bank accounts to see balances and transactions.")
                        )
                    }
                }
            }
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingLinkAccount = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingLinkAccount) {
                LinkAccountView()
            }
            .navigationDestination(for: Account.self) { account in
                AccountDetailView(account: account)
            }
        }
    }

    private func displayName(for type: String) -> String {
        switch type {
        case "depository": return "Cash"
        case "credit": return "Credit Cards"
        case "loan": return "Loans"
        case "investment": return "Investments"
        default: return type.capitalized
        }
    }
}

struct AccountRow: View {
    let account: Account

    private var typeColor: Color {
        BMTheme.colorForAccountType(account.type)
    }

    var body: some View {
        HStack(spacing: BMTheme.spacingMD) {
            // Colored type icon
            Image(systemName: BMTheme.iconForAccountType(account.type))
                .font(.body)
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(typeColor)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(account.name)
                    .font(.body.weight(.medium))
                if let mask = account.mask {
                    Text("••••\(mask)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text((account.balanceCurrent ?? 0).currencyFormatted)
                    .font(.body.weight(.semibold))
                if let available = account.balanceAvailable {
                    Text("\(available.currencyFormatted) available")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
    }
}
