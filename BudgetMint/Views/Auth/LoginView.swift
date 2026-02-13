import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @Environment(AuthService.self) private var authService
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var isLoading = false
    @State private var isGoogleLoading = false
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @FocusState private var focusedField: Field?

    private enum Field { case email, password }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                // App branding (animated)
                VStack(spacing: BMTheme.spacingSM) {
                    Image(systemName: "chart.pie.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(BMTheme.brandGreen)
                    Text("BudgetMint")
                        .font(.largeTitle.bold())
                    Text("Your personal finance tracker")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(BMTheme.springAnimation) {
                        logoScale = 1.0
                        logoOpacity = 1.0
                    }
                }

                // Form fields with icons
                VStack(spacing: 0) {
                    HStack(spacing: BMTheme.spacingMD) {
                        Image(systemName: "envelope.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 20)
                        TextField("Email", text: $email)
                            .focused($focusedField, equals: .email)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .padding(BMTheme.spacingMD)

                    Divider()
                        .padding(.leading, 44)

                    HStack(spacing: BMTheme.spacingMD) {
                        Image(systemName: "lock.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 20)
                        SecureField("Password", text: $password)
                            .focused($focusedField, equals: .password)
                            .textContentType(isSignUp ? .newPassword : .password)
                    }
                    .padding(BMTheme.spacingMD)
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: BMTheme.cornerMD))
                .padding(.horizontal)
                .onSubmit { submitForm() }

                // Error banner
                if let error = authService.errorMessage {
                    HStack(spacing: BMTheme.spacingSM) {
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text(error)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundStyle(.white)
                    .padding(BMTheme.spacingMD)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.red.opacity(0.85))
                    .clipShape(RoundedRectangle(cornerRadius: BMTheme.cornerSM))
                    .padding(.horizontal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }

                // Action button
                Button {
                    submitForm()
                } label: {
                    Group {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text(isSignUp ? "Create Account" : "Sign In")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(BMTheme.brandGreen)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: BMTheme.cornerMD))
                }
                .disabled(email.isEmpty || password.isEmpty || isLoading)
                .opacity(email.isEmpty || password.isEmpty || isLoading ? 0.6 : 1.0)
                .padding(.horizontal)

                // Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.secondary.opacity(0.3))
                    Text("or")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.secondary.opacity(0.3))
                }
                .padding(.horizontal)

                // Google Sign-In
                GoogleSignInButton(scheme: .dark, style: .wide) {
                    isGoogleLoading = true
                    Task {
                        await authService.signInWithGoogle()
                        isGoogleLoading = false
                    }
                }
                .disabled(isGoogleLoading)
                .opacity(isGoogleLoading ? 0.6 : 1.0)
                .padding(.horizontal)

                // Toggle sign up / sign in
                Button {
                    withAnimation(BMTheme.standardAnimation) {
                        isSignUp.toggle()
                        authService.errorMessage = nil
                    }
                } label: {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .font(.footnote)
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { focusedField = nil }
                }
            }
            .animation(BMTheme.standardAnimation, value: authService.errorMessage)
        }
    }

    private func submitForm() {
        guard !email.isEmpty, !password.isEmpty, !isLoading else { return }
        isLoading = true
        Task {
            if isSignUp {
                await authService.signUp(email: email, password: password)
            } else {
                await authService.signIn(email: email, password: password)
            }
            isLoading = false
        }
    }
}
