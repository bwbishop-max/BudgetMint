import SwiftUI
import LinkKit

struct LinkAccountView: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @SwiftUI.Environment(FirestoreService.self) private var firestoreService
    @State private var linkToken: String?
    @State private var isPresentingLink = false
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var statusMessage: String?
    @State private var linkHandler: Handler?

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
                            openPlaidLink()
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
            .fullScreenCover(isPresented: $isPresentingLink) {
                if let linkHandler {
                    LinkController(handler: linkHandler)
                        .ignoresSafeArea(.all)
                }
            }
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

    private func openPlaidLink() {
        guard let token = linkToken else { return }

        var config = LinkTokenConfiguration(token: token) { success in
            isPresentingLink = false
            handleLinkSuccess(publicToken: success.publicToken)
        }
        config.onExit = { exit in
            isPresentingLink = false
            if let error = exit.error {
                errorMessage = "Link error: \(error.displayMessage ?? error.errorCode.description)"
            }
        }

        let result = Plaid.create(config)
        switch result {
        case .success(let handler):
            linkHandler = handler
            isPresentingLink = true
        case .failure(let error):
            errorMessage = "Failed to initialize Link: \(error.localizedDescription)"
        }
    }

    private func handleLinkSuccess(publicToken: String) {
        statusMessage = nil
        isLoading = true
        Task {
            do {
                let itemId = try await plaidService.exchangePublicToken(publicToken)
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

// MARK: - UIViewControllerRepresentable bridge for Plaid Link
struct LinkController: UIViewControllerRepresentable {
    let handler: Handler

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        handler.open(presentUsing: .custom({ linkViewController in
            viewController.addChild(linkViewController)
            viewController.view.addSubview(linkViewController.view)
            linkViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                linkViewController.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                linkViewController.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                linkViewController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                linkViewController.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])
            linkViewController.didMove(toParent: viewController)
        }))
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
