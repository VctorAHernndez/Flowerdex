//
//  FlowerItem.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 11/11/20.
//

import Foundation

struct FlowerItem: Hashable, Codable, Identifiable {
    let id: Int
    let common_name: String?
    var commonName: String {
        if let cm = common_name {
            return cm
        } else {
            return scientificName
        }
    }
    let slug: String // *
    let scientific_name: String
    var scientificName: String { scientific_name }
    let year: Int?
    let bibliography: String?
    let author: String? // *
    let status: String // *
    let rank: String // *
    let family_common_name: String?
    var familyCommonName: String {
        if let fcn = family_common_name {
            return fcn
        } else {
            return "[Family Common Name]"
        }
    }
    let genus_id: Int // *
    var genusID: Int { genus_id }
    let image_url: String?
    var imageURL: String {
        if let iu = image_url {
            return iu
        } else {
            return "[Image URL]"
        }
    }
    let synonyms: [String]
    let genus: String
    let family: String
    let links: Dictionary<String, String> // FlowerLinks
    
    // Properties added by us
    let isFavorite: Bool
    let hasBeenFound: Bool
}

/*
struct FlowerLinks: Codable {
    // let self: String
    let plant: String
    let genus: String
}
*/
