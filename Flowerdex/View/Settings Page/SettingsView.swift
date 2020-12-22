//
//  SettingsView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/21/20.
//

import SwiftUI

struct SettingsView: View {
    @State var loading = false
    var body: some View {
        VStack {
            AccountDetails()
            Spacer()
    
            if loading {
                ProgressView("Logging out...")
                Spacer()
            }
            
            Button(action: {
                User.logout()
                // TODO: notify MainView of change
                loading.toggle()
            }) {
                LogoutButtonText(loading: $loading)
            }
            .disabled(loading)
            
        }
        .padding(30)
    }
}

struct LogoutButtonText: View {
    @Binding var loading: Bool
    var body: some View {
        Text("Logout")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 50)
            .background(loading ? Color.gray : Color.red)
            .cornerRadius(5)
    }
}

struct AccountDetails: View {
    var body: some View {
        Text("Account Details")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Constants.Colors.blueGray)
            .frame(width: 350, height: 25, alignment: .topLeading)
            .padding(.bottom, 25)
        VStack(alignment: .leading) {
            Text("Username")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Constants.Colors.rausch)
            Text(User.current.username!)
                .font(.title3)
                .foregroundColor(Constants.Colors.blueGray)
                .padding(.vertical)
                .padding(.leading)
            Text("Email")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Constants.Colors.rausch)
            Text(User.current.email)
                .font(.title3)
                .foregroundColor(Constants.Colors.blueGray)
                .padding(.vertical)
                .padding(.leading)
        }
        .padding()
        .frame(width: 350, alignment: .leading)
        
        
    }
}
