//
//  RegisterView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var rModel: RegistrationModel
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @Binding var showingRegistrationPane: Bool
    @State var showingMissingFieldsAlert = false
    @State var showingPasswordsMismatchAlert = false
    
    var body: some View {
        VStack {
            
            // NOTE: Chaining alerts in SwiftUI is prohibited,
            // hence, I attach them to two separate views as a hack
            // SEE: https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-multiple-alerts-in-a-single-view
            
            RegistrationText()
            RegistrationFields(username: $username, email: $email, password: $password, confirmPassword: $confirmPassword)
            RegistrationStatusText()
            
            
            // Register Button
            Button(action: {
                
                // Reset booleans before reassignment below
                showingPasswordsMismatchAlert = false
                showingMissingFieldsAlert = false
                
                let data = RegistrationData(username: username, email: email, password: password)
                
                if data.isComplete() {
                    if password == confirmPassword {
                        rModel.register(data: data)
                    } else {
                        self.showingPasswordsMismatchAlert = true
                        
                    }
                } else {
                    self.showingMissingFieldsAlert = true
                }
                
            }) {
                RegistrationButtonText()
            }
            .alert(isPresented: $showingMissingFieldsAlert) {
                Alert(title: Text("Fields incomplete"), message: Text("Please enter a all required information"), dismissButton: .default(Text("OK")))
            }
            
            
            // Back Button
            Button(action: {self.showingRegistrationPane = false}, label: {
                BackButtonText()
            })
            .alert(isPresented: $showingPasswordsMismatchAlert) {
                Alert(title: Text("Passwords do not match"), message: Text("Please retype your password and try again"), dismissButton: .default(Text("OK")))
            }
            
            
        }
        .padding()
    }
}

struct RegistrationFields: View {
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            Group {
                TextField("Username", text: $username)
                    .autocapitalization(.words)
                    .padding()
                    .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 5)
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 5)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding()
                    .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 5)
                SecureField("Confirm Password", text: $confirmPassword)
                    .autocapitalization(.none)
                    .padding()
                    .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 5)
            }.padding(5)
        }
    }
}

struct RegistrationText: View {
    var body: some View {
        Text("Details")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Constants.Colors.blueGray)
            .frame(width: 350, height: 25, alignment: .topLeading)
            .padding(.bottom, 20)
    }
}

struct RegistrationButtonText: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("Register")
            .font(.headline)
            .foregroundColor(colorScheme == .dark ? Constants.Colors.darkGrayColor : .white)
            .padding()
            .frame(width: 220, height: 50)
            .background(Constants.Colors.rausch) // Color.blue
            .cornerRadius(5)
            .padding(.bottom, 5)
    }
}

struct RegistrationStatusText: View {
    @EnvironmentObject var rModel: RegistrationModel
    var body: some View {
        if rModel.response == .failure {
            Text("Registration failed, please try again")
                //.offset(y: -5)
                .foregroundColor(.red)
        } else if rModel.response == .loading {
            ProgressView("Loading…")
                .padding()
        } else if rModel.response == .success {
            Text("Registration successful 🎉")
                //.offset(y: -5)
                .foregroundColor(.green)
        }
    }
}
