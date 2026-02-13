import SwiftUI
import FirebaseAuth
import GoogleSignIn

struct SettingsView: View {
    @Environment(AuthService.self) private var authService
    @Environment(FirestoreService.self) private var firestoreService
    @State private var showingSignOutConfirmation = false

    private var userEmail: String {
        Auth.auth().currentUser?.email ?? "Unknown"
    }

    private var authProvider: String {
        let providerIDs = Auth.auth().currentUser?.providerData.map(\.providerID) ?? []
        if providerIDs.contains("google.com") {
            return "Google"
        }
        return "Email"
    }

    var body: some View {
        NavigationStack {
            List {
                // Account
                Section("Account") {
                    LabeledContent("Email") {
                        Text(userEmail)
                            .foregroundStyle(.secondary)
                    }
                    LabeledContent("Sign-in Method") {
                        Text(authProvider)
                            .foregroundStyle(.secondary)
                    }
                }

                // Linked Accounts
                Section("Linked Accounts") {
                    LabeledContent("Accounts") {
                        Text("\(firestoreService.accounts.count)")
                    }
                    LabeledContent("Transactions") {
                        Text("\(firestoreService.transactions.count)")
                    }
                }

                // About
                Section("About") {
                    LabeledContent("Version") {
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                            .foregroundStyle(.secondary)
                    }
                }

                // Sign Out
                Section {
                    Button(role: .destructive) {
                        showingSignOutConfirmation = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .confirmationDialog("Sign Out", isPresented: $showingSignOutConfirmation, titleVisibility: .visible) {
                Button("Sign Out", role: .destructive) {
                    firestoreService.stopListening()
                    authService.signOut()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
}
