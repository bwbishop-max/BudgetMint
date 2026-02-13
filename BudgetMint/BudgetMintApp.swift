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
        }
    }
}
