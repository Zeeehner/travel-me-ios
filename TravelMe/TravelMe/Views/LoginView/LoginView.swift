//
//  LoginView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

// The LoginView handles the user login and registration process
struct LoginView: View {
    
    // Accessing the AuthViewModel to manage authentication logic and state
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    // ObservedObject for HomeViewModel to manage home-related logic
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        // NavigationStack allows for stack-based navigation and navigation bar management
        NavigationStack {
            ZStack {
                // Gradient background to make the UI visually appealing
                GradientView()
                
                // VStack to stack elements vertically
                VStack {
                    Spacer()
                    
                    // App logo displayed at the top, with adjusted size and shadow for visual effect
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .opacity(0.8)
                        .shadow(radius: 30)
                    
                    Spacer()
                    
                    // Grouping of TextField inputs for login or registration form
                    Group {
                        // Email input field, valid email will be green, invalid will be red
                        TextField("E-Mail", text: $authViewModel.email)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(authViewModel.isValidEmail ? .primary : .red)
                        
                        // Registration-specific fields (only shown when registering)
                        if authViewModel.isRegistering {
                            // Username input field
                            TextField("Name", text: $authViewModel.username)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.none)
                            
                            // Address input field
                            TextField("Adress", text: $authViewModel.adress)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.none)
                            
                            // Date picker for the user's birthday
                            HStack {
                                Text("Your birthday:")
                                    .bold()
                                    .padding()
                                Spacer()
                                DatePicker("", selection: $authViewModel.birthday, in: ...Date(), displayedComponents: .date)
                                    .datePickerStyle(.compact)
                            }
                            
                            // Picker for gender selection
                            HStack {
                                Text("Selected gender:")
                                    .bold()
                                    .padding()
                                Spacer()
                                Picker("Select your gender", selection: $authViewModel.gender) {
                                    ForEach(authViewModel.genderOptions, id: \.self) { gen in
                                        Text(gen)
                                    }
                                }
                            }
                        }
                        
                        // Password input field
                        SecureField("Password", text: $authViewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .onSubmit {
                                // Trigger login when the user submits the form
                                Task {
                                    await authViewModel.loginEmailPassword()
                                }
                            }
                        
                        // Show "Forgot Password?" button if not registering
                        if !authViewModel.isRegistering {
                            Button(action: {
                                // Trigger password reset process
                                Task {
                                    await authViewModel.resetPassword()
                                }
                            }) {
                                Text("Forgot Password?")
                                    .foregroundStyle(.blue)
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 5)
                        }
                        
                        // Confirm password input field (only shown when registering)
                        if authViewModel.isRegistering {
                            SecureField("Confirm password", text: $authViewModel.confirmPassword)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.none)
                        }
                    }
                    
                    // Display error message if any
                    Text(authViewModel.errorMessage)
                        .foregroundStyle(.red)
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                        .opacity(authViewModel.errorMessage.isEmpty ? 0 : 1)
                        .animation(.easeInOut, value: authViewModel.errorMessage)
                        .onAppear {
                            // Clear the error message after 3 seconds
                            if !authViewModel.errorMessage.isEmpty {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    authViewModel.errorMessage = ""
                                }
                            }
                        }
                    
                    // Login/Registration button
                    Button(action: {
                        // Perform either registration or login based on the flag
                        if authViewModel.isRegistering {
                            Task {
                                await authViewModel.registerEmailPassword()
                            }
                        } else {
                            Task {
                                await authViewModel.loginEmailPassword()
                            }
                        }
                    }) {
                        // Label changes text based on whether the user is registering or logging in
                        Label(authViewModel.isRegistering ? "Register" : "Login", systemImage: "person.fill")
                    }
                    .frame(height: 100)
                    .disabled(!authViewModel.isRegisterInputValid) // Disable button if inputs are not valid
                    .buttonStyle(.borderedProminent)
                    
                    // Anonymous login button
                    Button("Anonymous Login")  {
                        // Trigger anonymous login if pressed
                        Task {
                            await authViewModel.loginAnonymously()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    // Toggle between login and register views
                    Button(authViewModel.isRegistering ? "Already have an account?" : "Create new account") {
                        authViewModel.isRegistering.toggle() // Switch to the opposite view
                    }
                }
                .padding() // Add padding around all elements
            }
            .navigationTitle(authViewModel.isRegistering ? "Register" : "Login") // Dynamic title
        }
    }
}


#Preview {
    LoginView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
