import SwiftUI
import FirebaseCore

@main
struct BudgetMintApp: App {
    @State private var authService: AuthService
    @State private var firestoreService: FirestoreService

    init() {
        FirebaseApp.configure()
        _authService = State(initialValue: AuthService())
        _firestoreService = State(initialValue: FirestoreService())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authService)
                .environment(firestoreService)
                #if DEBUG
                .task {
                    if let email = ProcessInfo.processInfo.environment["TEST_EMAIL"],
                       let password = ProcessInfo.processInfo.environment["TEST_PASSWORD"] {
                        await authService.signIn(email: email, password: password)
                    }
                }
                #endif
        }
    }
}
