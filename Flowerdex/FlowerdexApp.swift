//
//  FlowerdexApp.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import SwiftUI

@main
struct FlowerdexApp: App {
    @StateObject var lm = LoginModel()
    @StateObject var rm = RegistrationModel()
    @StateObject var fm = FlowerService()
    var body: some Scene {
        WindowGroup {
            if User.exists() {
                DiscoverView()
                    .environmentObject(fm)
            } else {
                LoginView()
                    .environmentObject(lm)
                    .environmentObject(rm)
            }
        }
    }
}

