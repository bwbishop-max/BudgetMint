import Foundation
import FirebaseAuth

@Observable
class AuthService {
    var currentUser: User?
    var isAuthenticated: Bool { currentUser != nil }
    var errorMessage: String?

    private var authStateListener: AuthStateDidChangeListenerHandle?

    init() {
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.currentUser = user
        }
    }

    func signIn(email: String, password: String) async {
        do {
            errorMessage = nil
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = result.user
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signUp(email: String, password: String) async {
        do {
            errorMessage = nil
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUser = result.user
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
