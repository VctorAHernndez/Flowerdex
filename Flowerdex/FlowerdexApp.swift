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
    @StateObject var hm = HistoryService()
    var body: some Scene {
        WindowGroup {
            if User.exists() {
                MainView()
                    .environmentObject(fm)
                    .environmentObject(hm)
            } else {
                LoginView()
                    .environmentObject(lm)
                    .environmentObject(rm)
            }
        }
    }
}

