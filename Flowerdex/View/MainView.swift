//
//  MainView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/21/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("History")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(Constants.Colors.rausch)
    }
}
