//
//  LoginView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var lModel: LoginModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showingRegistrationPane: Bool = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            
            WelcomeImage()
            WelcomeText()
            EmailField(email: $email)
            PasswordField(password: $password)
            LoginStatusText()
            
            // Login Button
            Button(action: {
                let authData = LoginData(email: email, password: password)
                if authData.isComplete() {
                    lModel.login(data: authData)
                } else {
                    self.showingAlert = true
                }
                
            }) {
                LoginButtonText()
            }
            
            // Register Button
            Button(action: {self.showingRegistrationPane.toggle()}) {
                PromptRegisterText()
            }
            .sheet(isPresented: $showingRegistrationPane, content: { RegisterView(showingRegistrationPane: $showingRegistrationPane) })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Fields incomplete"), message: Text("Please enter a valid email and password"), dismissButton: .default(Text("OK")))
                
            }
        }
        .padding()
    }
}


struct LoginStatusText: View {
    @EnvironmentObject var lModel: LoginModel
    var body: some View {
        if lModel.response == .failure {
            Text("No user with given credentials")
                .offset(y: -10)
                .foregroundColor(.red)
        } else if lModel.response == .success {
            Text("Login successful 🎉")
                .offset(y: -10)
                .foregroundColor(.green)
        } else if lModel.response == .loading {
            ProgressView("Loading…")
                .padding()
        }
    }
}


struct WelcomeText: View {
    var body: some View {
        Text("Flowerdex")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color("Blue Gray"))
            .padding(.bottom, 20)
    }
}

struct WelcomeImage: View {
    let size: CGFloat = 220
    var body: some View {
        // TODO: change this to app icon
        Image("amapola")
            
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipped()
            .cornerRadius(size)
//            .padding(.bottom, size / 4)
    }
}

struct LoginButtonText: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("Login")
            .font(.headline)
            .foregroundColor(colorScheme == .dark ? Constants.Colors.darkGrayColor : .white)
            .padding()
            .frame(width: 220, height: 50)
            .background(Color("Rausch")) // Color.blue
            .cornerRadius(5)
            .padding(.bottom, 5)
    }
}

struct PromptRegisterText: View {
    var body: some View {
        Text("Don't have an account? Register")
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color.clear)
            .cornerRadius(5)
    }
}

struct EmailField: View {
    @Binding var email: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TextField("Email", text: $email)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
            .cornerRadius(5.0)
            .padding(.bottom, 5)
    }
}

struct PasswordField: View {
    @Binding var password: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        SecureField("Password", text: $password)
            .autocapitalization(.none)
            .padding()
            .background(colorScheme == .dark ? Constants.Colors.darkGrayColor : Constants.Colors.lightGrayColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
