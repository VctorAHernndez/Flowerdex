//
//  Filters.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/1/20.
//

import Foundation

class Filters {
    
    var edible: Bool
    var vegetable: Bool
    var petalCount: Int
    var growthMonths: Int
    var bloomMonths: Int
    var scientificName: String
    var commonName: String
    var flowerColor: String
    
    init(edible: Bool, vegetable: Bool, petalCount: Int, growthMonths: Int, bloomMonths: Int, scientificName: String, commonName: String, flowerColor: String) {
        self.edible = edible
        self.vegetable = vegetable
        self.petalCount = petalCount
        self.growthMonths = growthMonths
        self.bloomMonths = bloomMonths
        self.scientificName = scientificName
        self.commonName = commonName
        self.flowerColor = flowerColor
    }
    
}
