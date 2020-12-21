//
//  FlowersResponseModel.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import Foundation

struct FlowersResponseModel: Hashable, Codable {
    let data: [Flower]?
    let links: Dictionary<String, String>?
    let meta: Dictionary<String, Int>?
    let error: String?
}

// TODO: probably adopt this model instead of decoding user directly
//struct UserResponseModel: Hashable, Codable {
//    let id: Int?
//    let username: String?
//    let email: String?
//    let password: String?
//    let error: String?
//}
