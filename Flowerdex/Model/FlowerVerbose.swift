//
//  FlowerVerbose.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/21/20.
//

import Foundation

struct FlowerVerbose: Hashable, Identifiable, Codable {
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
    
    let image_url: String?
    var imageURL: String {
        if let iu = image_url {
            return iu
        } else {
            return "[Image URL]"
        }
    }
    
    let year: Int?
    let bibliography: String?
    let author: String? // *
    
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
    
    let observations: String? // new
    let vegetable: Bool? // new
    let links: FlowerLinks
    let genus: GenusVerbose? // changed
    let family: FamilyVerbose? // changed
    let species: [Flower]? // new
    
//    let subspecies: []
//    let varieties: []
//    let hybrids: []
//    let forms : []
//    let subvarieties: []
//    let sources: []
    
    // Properties added by us
    let isFavorite: Bool
    let hasBeenFound: Bool
}

struct GenusVerbose: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let slug: String
    let links: FlowerLinks
}

struct FamilyVerbose: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let common_name: String
    let slug: String
    let links: FlowerLinks
}

/*
 "id": 238331,
 "common_name": null,
 "slug": "senecio-gamolepis",
 "scientific_name": "Senecio gamolepis",
 "main_species_id": 273225,
 "image_url": null,
 "year": 1955,
 "bibliography": "Notas Mus. La Plata, Bot. 18(89): 222 (1955)",
 "author": "Cabrera",
 "family_common_name": "Aster family",
 "genus_id": 669,
 "observations": "Peru",
 "vegetable": false,
 "links": {},
 "main_species": {},
 "genus": {},
 "family": {},
 "species": [],
 "subspecies": [ ],
 "varieties": [ ],
 "hybrids": [ ],
 "forms": [ ],
 "subvarieties": [ ],
 "sources": []
 */
