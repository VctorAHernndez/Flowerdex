//
//  DiscoverView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import SwiftUI

struct DiscoverView: View {
    
    @EnvironmentObject var fModel: FlowerService
    @State var showingFilterPane: Bool = false
    @State var page: Int = 1
    
    // Filter Variables
    @State var edible: Bool = false
    @State var vegetable: Bool = false
    @State var petalCount: Int = 0
    @State var growthMonths: Int = 0
    @State var bloomMonths: Int = 0
    @State var scientificName: String = ""
    @State var commonName: String = ""
    
    init() {
        // FROM: https://sarunw.com/posts/uinavigationbar-changes-in-ios13/
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Constants.Colors.blueGray)] // small, collapsed title
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Constants.Colors.rausch)] // large title
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollableSearchedContent()
            }
            .navigationBarTitle("Discover")
            .navigationBarItems(trailing:
                Button(action: {self.showingFilterPane = true}) {
                    FilterButtonIcon()
                }
                .sheet(isPresented: $showingFilterPane, content: {
                    FiltersSheet(showingFilterPane: $showingFilterPane, page: $page, edible: $edible, vegetable: $vegetable, petalCount: $petalCount, growthMonths: $growthMonths, bloomMonths: $bloomMonths, scientificName: $scientificName, commonName: $commonName)
                })
            )
        }
        .onAppear {
            self.fModel.getFlowers(p: page, f: nil)
        }
    }
    
}

struct ScrollableSearchedContent: View {
    @EnvironmentObject var fModel: FlowerService
    var body: some View {
        if fModel.response == .success {
            FlowersList(flowerList: fModel.items)
        } else if fModel.response == .loading || fModel.response == .unfetched {
            // TODO: make this centered vertically within parent ScrollView
            ProgressView("Loading...")
        } else if fModel.response == .failure {
            // TODO: make this centered vertically within parent ScrollView
            FailureIcon()
        }
    }
}

struct FilterButtonIcon: View {
    var body: some View {
        Image(systemName: "slider.horizontal.3")
            .font(.title)
            .foregroundColor(Constants.Colors.rausch)
    }
}
