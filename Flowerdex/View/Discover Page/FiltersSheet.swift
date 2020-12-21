//
//  FiltersSheet.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/2/20.
//

import SwiftUI

struct FiltersSheet: View {

    @EnvironmentObject var fModel: FlowerService
    @Binding var showingFilterPane: Bool
    @Binding var page: Int
    
    // Filter Variables
    @Binding var edible: Bool
    @Binding var vegetable: Bool
    @Binding var petalCount: Int
    @Binding var growthMonths: Int
    @Binding var bloomMonths: Int
    @Binding var scientificName: String
    @Binding var commonName: String
    @Binding var flowerColor: String

    var body: some View {
        FilterFields(edible: $edible, vegetable: $vegetable, petalCount: $petalCount, growthMonths: $growthMonths, bloomMonths: $bloomMonths, scientificName: $scientificName, commonName: $commonName, flowerColor: $flowerColor)
        
        Spacer()
        
        Button(action: {
            let filters = Filters(edible: edible, vegetable: vegetable, petalCount: petalCount, growthMonths: growthMonths, bloomMonths: bloomMonths, scientificName: scientificName, commonName: commonName, flowerColor: flowerColor)
            
            self.fModel.getFlowers(p: page, f: filters)
            
            self.showingFilterPane = false
        }, label: {
            ApplyButtonText()
        })
        
        Button(action: {self.showingFilterPane = false}, label: {
            BackButtonText()
        })
    }
}

struct ApplyButtonText: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("Apply")
            .font(.headline) // wasn't here originally
            .foregroundColor(colorScheme == .dark ? Constants.Colors.darkGrayColor : .white)
            .padding() // wasn't here originally
//            .padding(.horizontal)
//            .padding(.vertical, 10)
            .frame(width: 220, height: 50) // wasn't here originally
            .background(Color("Rausch"))
            .cornerRadius(5)
//            .padding(.bottom, 5) // dunno if worth adding
    }
}

struct BackButtonText: View {
    var body: some View {
        Text("Back")
            .foregroundColor(Constants.Colors.blueGray)
            .padding()
    }
}
