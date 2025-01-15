//
//  LoginView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                VStack {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .opacity(0.8)
                        .shadow(radius: 30)
                    Spacer()
                    
                    Group {
                        TextField("E-Mail", text: $authViewModel.email)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(authViewModel.isValidEmail ? .primary : .red)
                        
                        if authViewModel.isRegistering {
                            TextField("Name", text: $authViewModel.username)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.none)
                            
                            HStack {
                                Text("Your birthday:")
                                    .bold()
                                    .padding()
                                Spacer()
                                DatePicker("", selection: $authViewModel.birthday, in: ...Date(), displayedComponents: .date)
                                    .datePickerStyle(.compact)
                            }
                            
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
                        
                        SecureField("Password", text: $authViewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .onSubmit {
                                Task {
                                    await authViewModel.loginEmailPassword()
                                }
                            }
                        if !authViewModel.isRegistering {
                            Button(action: {
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
                        if authViewModel.isRegistering {
                            SecureField("Confirm password", text: $authViewModel.confirmPassword)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.none)
                        }
                    }
                    
                    Text(authViewModel.errorMessage)
                        .foregroundStyle(.red)
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                        .opacity(authViewModel.errorMessage.isEmpty ? 0 : 1)
                        .animation(.easeInOut, value: authViewModel.errorMessage)
                        .onAppear {
                            if !authViewModel.errorMessage.isEmpty {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    authViewModel.errorMessage = ""
                                }
                            }
                        }
                    
                    Button(action: {
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
                        Label(authViewModel.isRegistering ? "Register" : "Login", systemImage: "person.fill")
                    }
                    .frame(height: 100)
                    .disabled(!authViewModel.isRegisterInputValid)
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    Button(authViewModel.isRegistering ? "Already have an account?" : "Create new account") {
                        authViewModel.isRegistering.toggle()
                    }
                }
                .padding()
            }
            .navigationTitle(authViewModel.isRegistering ? "Register" : "Login")
        }
    }
}

#Preview {
    LoginView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
