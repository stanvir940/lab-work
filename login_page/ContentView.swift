import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var isLoginMode = true
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                // Toggle between login and sign up
                Picker("Mode", selection: $isLoginMode) {
                    Text("Login").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Username Field
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Email Field (only shown for sign up)
                if !isLoginMode {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // Password Field
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Action Button
                Button(action: {
                    handleAction()
                }) {
                    Text(isLoginMode ? "Login" : "Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .navigationTitle(isLoginMode ? "Login" : "Sign Up")
            .padding()
        }
    }

    // Handle login or sign up action with Firebase
    func handleAction() {
        if isLoginMode {
            // Login logic
            if username.isEmpty || password.isEmpty {
                alertMessage = "Please fill in both username and password."
                showAlert = true
            } else {
                loginUser()
            }
        } else {
            // Sign Up logic
            if username.isEmpty || password.isEmpty || email.isEmpty {
                alertMessage = "Please fill in all fields."
                showAlert = true
            } else {
                signUpUser()
            }
        }
    }

    // Firebase Login
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = "Login failed: \(error.localizedDescription)"
                showAlert = true
            } else {
                // Successfully logged in
                alertMessage = "Login successful"
                showAlert = true
                print("Logged in as: \(result?.user.email ?? "")")
            }
        }
    }

    // Firebase Sign Up
    func signUpUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = "Sign up failed: \(error.localizedDescription)"
                showAlert = true
            } else {
                // Successfully signed up
                alertMessage = "Sign up successful"
                showAlert = true
                print("Signed up as: \(result?.user.email ?? "")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

