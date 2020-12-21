//
//  FlowerService.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import Foundation

class FlowerService: ObservableObject {
    
    @Published var response: Response = .unfetched
    @Published var items = [FlowerItem]()
    
    
    private func getQueryParameters(_ filters: Filters) -> [URLQueryItem] {
        
        var list = [URLQueryItem]()
        list.append(URLQueryItem(name: "edible", value: "\(filters.edible)"))
        list.append(URLQueryItem(name: "vegetable", value: "\(filters.vegetable)"))
        
        if filters.commonName != "" {
            list.append(URLQueryItem(name: "q", value: filters.commonName))
        }
//        list.append(URLQueryItem(name: "common_name", value: filters.commonName)) // if common_name was empty, which didn't make sense
        

        if filters.scientificName != "" {
            list.append(URLQueryItem(name: "scientific_name", value: filters.scientificName))
        }
        
        if filters.growthMonths > 0 {
            list.append(URLQueryItem(name: "growth_months", value: "\(filters.growthMonths)"))
        }
        
        if filters.bloomMonths > 0 {
            list.append(URLQueryItem(name: "bloom_months", value: "\(filters.bloomMonths)"))
        }
        
        return list
        
    }
    
    
    private func getBaseURLComponent(_ apiPath: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.Services.apiScheme
        components.host = Constants.Services.apiHost
        components.path = apiPath
        components.queryItems = [
            URLQueryItem(name: "user_id", value: "\(User.current.id!)"),
        ]
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
            
            guard let apiResponse = try? JSONDecoder().decode(FlowersResponseModel.self, from: data) else {
                print("Failed to decode Trefle response")
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
//                        self.items = [FlowerItem]()
                    }
                }
            }
        }.resume()
    }
    
    
    func getFlowers(p page: Int = 1, f filters: Filters?) {
        
        // Start loading state
        self.response = .loading
        
        // Construct URL
        var components = self.getBaseURLComponent(Constants.Services.apiGetFlowersPath)
        if filters != nil {
            components.queryItems!.append(contentsOf: self.getQueryParameters(filters!))
        }
        components.queryItems!.append(URLQueryItem(name: "page", value: "\(page)"))
        
        // Prepare and carry out request
//        print("😂" + components.url!.absoluteString)
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        self.fetchFlowers(request)
        
    }
    
}
