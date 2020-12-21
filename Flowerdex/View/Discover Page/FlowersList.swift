//
//  FlowersList.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/2/20.
//

import SwiftUI

struct FlowersList: View {
    var flowerList: [Flower]
    var body: some View {
        if flowerList.count == 0 {
            // TODO: make this centered vertically within parent ScrollView
            NoMatchIcon()
        } else {
            LazyVStack {
                ForEach(flowerList) { flower in
                    NavigationLink(destination: FlowerDetailView(flower: flower, hasBeenFoundLocal: flower.hasBeenFound)) {
                        FlowerCard(flower: flower)
                    }
                    .foregroundColor(Constants.Colors.blueGray)
                }
            }
        }
    }
}

struct FlowersList_Previews: PreviewProvider {
    static var previews: some View {
        FlowersList(flowerList: dummyFlowers) // use: [] or dummyFlowers
    }
}
