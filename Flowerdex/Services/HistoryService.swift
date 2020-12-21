//
//  HistoryService.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/21/20.
//

import Foundation

class HistoryService: ObservableObject {
    
    @Published var response: Response = .unfetched
    @Published var items = [FlowerVerbose]()
    
    
    private func getBaseURLComponent(_ apiPath: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.Services.apiScheme
        components.host = Constants.Services.apiHost
        components.path = apiPath
        if apiPath == Constants.Services.apiGetHistoryPath {
            components.queryItems = [
                URLQueryItem(name: "user_id", value: "\(User.current.id!)"),
            ]
        }
        return components
    }
    
    
    private func fetchFlowers(_ request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.response = .failure
                }
                return
            }
            print(response ?? "No response")
//            print("Recieved data:", String(decoding: data, as: UTF8.self))
            
            guard let apiResponse = try? JSONDecoder().decode(HistoryResponseModel.self, from: data) else {
                print("Failed to decode History response")
                DispatchQueue.main.async {
                    self.response = .failure
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 && apiResponse.error == nil {
                        print("No error")
                        self.response = .success
                        self.items = apiResponse.data!
                    } else {
                        print("Error: \(apiResponse.error ?? "Unknown error")")
                        self.response = .failure
//                        self.items = [FlowerVerbose]()
                    }
                }
            }
        }.resume()
    }
    
    
    func getHistory() {
        
        // Start loading state
        self.response = .loading
        
        // Construct URL
        let components = getBaseURLComponent(Constants.Services.apiGetHistoryPath)
        
        // Prepare and carry out request
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        self.fetchFlowers(request)
        
    }
    
    
    func getWishlist() {
        
        // Start loading state
        self.response = .loading
        
        // Construct URL
        let components = getBaseURLComponent(Constants.Services.apiGetWishlistPath)
        
        // Prepare and carry out request
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        self.fetchFlowers(request)
        
    }
    
    
    
}
