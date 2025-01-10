//
//  LoginView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {
    
    @EnvironmentObject private var authViewModel : AuthViewModel
    @ObservedObject var homeViewModel : HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Placeholder for image
                
                Spacer()
                if authViewModel.isRegistering {
                    Button("Anonymous Login") {
                        Task {
                            await authViewModel.loginAnonymously()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    Text("Or signup")
                        .font(.subheadline)
                        .opacity(0.3)
                }
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
            }
            SecureField("Password", text: $authViewModel.password)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .onSubmit {
                    Task {
                        await authViewModel.loginEmailPassword()
                    }
                }
            if authViewModel.isRegistering {
                SecureField("Confirm password", text: $authViewModel.confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
            }
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
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
        .navigationTitle(authViewModel.isRegistering ? "Register" : "Login")
    }
}

#Preview {
    LoginView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
