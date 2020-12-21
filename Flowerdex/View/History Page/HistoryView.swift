//
//  HistoryView.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/21/20.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var hModel: HistoryService
    var body: some View {
        NavigationView {
            ScrollableHistoryContent()
        }
        .onAppear {
            self.hModel.getHistory()
        }
    }
}

struct ScrollableHistoryContent: View {
    @EnvironmentObject var hModel: HistoryService
    var body: some View {
        if hModel.response == .success {
            List {
                HistoryList(flowerList: hModel.items)
            }
            .navigationBarTitle("Discover")
        } else if hModel.response == .loading || hModel.response == .unfetched {
            // TODO: make this centered vertically within parent ScrollView
            ProgressView("Loading...")
        } else if hModel.response == .failure {
            // TODO: make this centered vertically within parent ScrollView
            FailureIcon()
        }
    }
}

struct HistoryList: View {
    var flowerList: [FlowerVerbose]
    var body: some View {
        ForEach(flowerList) { flower in
            NavigationLink(destination: FlowerVerboseDetailView(flower: flower, hasBeenFoundLocal: flower.hasBeenFound)) {
                Text(flower.commonName.capitalized)
            }
//                    .foregroundColor(Constants.Colors.blueGray)
        }
    }
}
