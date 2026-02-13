import SwiftUI
import LinkKit

struct LinkAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(FirestoreService.self) private var firestoreService
    @State private var linkToken: String?
    @State private var isPresentingLink = false
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var statusMessage: String?

    private let plaidService = PlaidService()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if isLoading {
                    ProgressView("Preparing link...")
                } else if let error = errorMessage {
                    ContentUnavailableView {
                        Label("Connection Error", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(error)
                    } actions: {
                        Button("Try Again") {
                            fetchLinkToken()
                        }
                    }
                } else if let status = statusMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.green)
                        Text(status)
                            .font(.headline)
                        Button("Done") {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.blue)
                        Text("Link Your Bank Account")
                            .font(.title2.bold())
                        Text("Securely connect your bank to import transactions and track balances.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Button("Connect Bank") {
                            isPresentingLink = true
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Link Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .plaidLink(
                isPresented: $isPresentingLink,
                token: linkToken ?? "",
                onSuccess: { success in
                    handleLinkSuccess(publicToken: success.publicToken)
                },
                onExit: { exit in
                    if let error = exit.error {
                        errorMessage = "Link error: \(error.displayMessage ?? error.errorCode.description)"
                    }
                }
            )
            .onAppear {
                fetchLinkToken()
            }
        }
    }

    private func fetchLinkToken() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                linkToken = try await plaidService.createLinkToken()
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    private func handleLinkSuccess(publicToken: String) {
        statusMessage = nil
        isLoading = true
        Task {
            do {
                let itemId = try await plaidService.exchangePublicToken(publicToken)
                // Sync transactions immediately after linking
                let result = try await plaidService.syncTransactions(itemId: itemId)
                statusMessage = "Account linked! Imported \(result.added) transactions."
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
