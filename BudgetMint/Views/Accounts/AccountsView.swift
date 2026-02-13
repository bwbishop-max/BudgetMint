import SwiftUI

struct AccountsView: View {
    @Environment(AuthService.self) private var authService
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
                            .foregroundStyle(firestoreService.totalNetWorth >= 0 ? .green : .red)
                    }
                    .padding(.vertical, 4)
                }

                // Accounts grouped by type
                ForEach(sortedAccountTypes, id: \.self) { type in
                    Section(header: Text(displayName(for: type))) {
                        ForEach(groupedAccounts[type] ?? []) { account in
                            AccountRow(account: account)
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
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign Out") {
                        firestoreService.stopListening()
                        authService.signOut()
                    }
                    .font(.footnote)
                }
            }
            .sheet(isPresented: $showingLinkAccount) {
                LinkAccountView()
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

    var body: some View {
        HStack {
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
        .padding(.vertical, 2)
    }
}
