import SwiftUI

struct LoginView: View {
    @Environment(AuthService.self) private var authService
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                // App branding
                VStack(spacing: 8) {
                    Image(systemName: "chart.pie.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(.green)
                    Text("BudgetMint")
                        .font(.largeTitle.bold())
                    Text("Your personal finance tracker")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                // Form fields
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(isSignUp ? .newPassword : .password)
                }
                .padding(.horizontal)

                // Error message
                if let error = authService.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Action button
                Button {
                    isLoading = true
                    Task {
                        if isSignUp {
                            await authService.signUp(email: email, password: password)
                        } else {
                            await authService.signIn(email: email, password: password)
                        }
                        isLoading = false
                    }
                } label: {
                    Group {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text(isSignUp ? "Create Account" : "Sign In")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(email.isEmpty || password.isEmpty || isLoading)
                .padding(.horizontal)

                // Toggle sign up / sign in
                Button {
                    isSignUp.toggle()
                    authService.errorMessage = nil
                } label: {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .font(.footnote)
                }

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
