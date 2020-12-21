//
//  HistoryResponseModel.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/21/20.
//

import Foundation

struct HistoryResponseModel: Hashable, Codable {
    let data: [FlowerVerbose]?
    let error: String?
}
