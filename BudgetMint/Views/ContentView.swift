import SwiftUI

struct ContentView: View {
    @Environment(AuthService.self) private var authService
    @Environment(FirestoreService.self) private var firestoreService

    var body: some View {
        Group {
            if authService.isAuthenticated {
                TabView {
                    DashboardView()
                        .tabItem {
                            Label("Dashboard", systemImage: "chart.pie.fill")
                        }

                    TransactionListView()
                        .tabItem {
                            Label("Transactions", systemImage: "list.bullet.rectangle.fill")
                        }

                    AccountsView()
                        .tabItem {
                            Label("Accounts", systemImage: "building.columns.fill")
                        }
                }
                .onAppear {
                    firestoreService.startListening()
                }
                .onDisappear {
                    firestoreService.stopListening()
                }
            } else {
                LoginView()
            }
        }
    }
}
