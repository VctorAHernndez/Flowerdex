//
//  ImageManager.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 11/12/20.
//

import Foundation
import SwiftUI

class ImageManager: ObservableObject {
    
    @Published var response: Response = .unfetched
    @Published var image = UIImage(systemName: "photo")
    
    func fetchImage(_ urlString: String) {
        
        // Start loading state
        self.response = .loading
        
        if let url = URL(string: urlString) {
            URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("Error occurred: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                DispatchQueue.main.async {
                    if let img = UIImage(data: data) {
                        self.image = img
                        self.response = .success
                    } else {
                        self.response = .failure
                    }
                }
                
            }.resume()
        }
    }
    
}

//
//class HistoryManager: ObservableObject {
//    
//    @Published var response: Response = .unfetched
//    @Published var hasBeenFound = false
//    let baseURL = "https://ada.uprrp.edu/~victor.hernandez17/"
//    let foundEndpoint = "flowerdex/isFoundFlower.php"
//    let putFoundEndpoint = "flowerdex/putFoundFlower.php"
//    let removeFoundEndpoint = "flowerdex/removeFoundFlower.php"
//    
//    func fetch() {
//        
//        // Start loading state
//        self.response = .loading
//        
//        let urlString = baseURL + foundEndpoint
//        
//        if let url = URL(string: urlString) {
//            URLSession(configuration: .default).dataTask(with: url) { data, response, error in
//                
//                if error != nil {
//                    print("Error occurred: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                guard let data = data else {
//                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    if let img = UIImage(data: data) {
//                        self.image = img
//                        self.response = .success
//                    } else {
//                        self.response = .failure
//                    }
//                }
//                
//            }.resume()
//        }
//    }URLSession.shared.dataTask(with: request) { data, response, error in
//    
//}
