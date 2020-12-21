//
//  FlowerService.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import Foundation

class FlowerService: ObservableObject {
    
    @Published var response: Response = .unfetched
    @Published var items = [Flower]()
    
    
    private func getQueryParameters(_ filters: Filters) -> [URLQueryItem] {
        
        var list = [URLQueryItem]()
        list.append(URLQueryItem(name: "edible", value: "\(filters.edible)"))
        list.append(URLQueryItem(name: "vegetable", value: "\(filters.vegetable)"))
        
        if filters.commonName != "" {
            list.append(URLQueryItem(name: "q", value: filters.commonName.lowercased()))
        }
//        list.append(URLQueryItem(name: "common_name", value: filters.commonName.lowercased())) // if common_name was empty, which didn't make sense
        

        if filters.scientificName != "" {
            list.append(URLQueryItem(name: "scientific_name", value: filters.scientificName.lowercased()))
        }
        
        if filters.growthMonths > 0 {
            list.append(URLQueryItem(name: "growth_months", value: "\(filters.growthMonths)"))
        }
        
        if filters.bloomMonths > 0 {
            list.append(URLQueryItem(name: "bloom_months", value: "\(filters.bloomMonths)"))
        }
        
        if filters.flowerColor != "" {
            list.append(URLQueryItem(name: "flower_color", value: filters.flowerColor.lowercased()))
        }
        
        return list
        
    }
    
    
    private func getBaseURLComponent(_ apiPath: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.Services.apiScheme
        components.host = Constants.Services.apiHost
        components.path = apiPath
        if apiPath == Constants.Services.apiGetFlowersPath {
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
    
    
    func wishlistOrHistorySkeletonRequest(_ flowerID: Int, remove: Bool, wishlist: Bool) {
        
        // Construct Body
        let jsonObject : [String: Int] = [
            "user_id": User.current.id!,
            "flower_id": flowerID
        ]
        
        guard let jsonData = try? JSONEncoder().encode(jsonObject) else {
            print("Failed to encode JSON for \(flowerID)")
            return
        }
        
        print(String(data: jsonData, encoding: .utf8)!)
        
        // Construct URL
        var path: String
        if remove {
            if wishlist {
                path = Constants.Services.apiRemoveFavoritePath
            } else {
                path = Constants.Services.apiRemoveFoundPath
            }
        } else {
            if wishlist {
                path = Constants.Services.apiPutFavoritePath
            } else {
                path = Constants.Services.apiPutFoundPath
            }
        }
        
        print((remove ? "removing " : "putting ") + (wishlist ? "favorite" : "found"))
        let components = getBaseURLComponent(path)
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        // Send POST request
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response ?? "No response")
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        // alert that we removed favorite
                        print("Success!")
                    } else {
                        // alert that we couldn't remove favorite
                        print("Error! \(httpResponse.statusCode)")
                    }
                }
            }
        }.resume()
    }
    
    
    func removeFavorite(_ flowerID: Int) {
        wishlistOrHistorySkeletonRequest(flowerID, remove: true, wishlist: true)
    }
    

    func putFavorite(_ flowerID: Int) {
        wishlistOrHistorySkeletonRequest(flowerID, remove: false, wishlist: true)
    }
    
    
    func removeFound(_ flowerID: Int) {
        wishlistOrHistorySkeletonRequest(flowerID, remove: true, wishlist: false)
    }

    func putFound(_ flowerID: Int) {
        wishlistOrHistorySkeletonRequest(flowerID, remove: false, wishlist: false)
    }
    
}
