import SwiftUI

struct ContentView: View {
    @Environment(AuthService.self) private var authService
    @Environment(FirestoreService.self) private var firestoreService
    @State private var selectedTab = 0

    var body: some View {
        Group {
            if authService.isAuthenticated {
                TabView(selection: $selectedTab) {
                    DashboardView()
                        .tag(0)
                        .tabItem {
                            Label("Dashboard", systemImage: "chart.pie.fill")
                        }

                    TransactionListView()
                        .tag(1)
                        .tabItem {
                            Label("Transactions", systemImage: "list.bullet.rectangle.fill")
                        }

                    AccountsView()
                        .tag(2)
                        .tabItem {
                            Label("Accounts", systemImage: "building.columns.fill")
                        }

                    SettingsView()
                        .tag(3)
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                }
                .tint(BMTheme.brandGreen)
                .onAppear {
                    if let tab = ProcessInfo.processInfo.environment["TEST_TAB"],
                       let index = Int(tab) {
                        selectedTab = index
                    }
                    firestoreService.startListening()
                }
                .onDisappear {
                    firestoreService.stopListening()
                }
            } else {
                LoginView()
            }
        }
        .animation(BMTheme.standardAnimation, value: authService.isAuthenticated)
    }
}
