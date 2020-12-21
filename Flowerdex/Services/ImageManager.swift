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
