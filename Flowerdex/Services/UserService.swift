//
//  UserService.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import Foundation

class LoginModel: ObservableObject {
    
    @Published var response: Response = .unfetched
    
    
    private func getBaseURL(_ apiPath: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.Services.apiScheme
        components.host = Constants.Services.apiHost
        components.path = apiPath
        return components.url!
    }
    
    
    private func authenticate(_ request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data
            else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.response = .failure
                }
                return
            }
            
            print(response ?? "No response")
            print("Received data:", data)
            print(error ?? "No error")
            
            guard let apiResponse = try? JSONDecoder().decode(User.self, from: data) else {
                print("Failed to decode ADA response")
                DispatchQueue.main.async {
                    self.response = .failure
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        self.response = .success
                        User.setCurrent(apiResponse, writeToUserDefaults: true) // TODO: change to false when other auth method is supplied
                    } else {
                        self.response = .failure
                    }
                }
            }
            
        }.resume()
    }
    
    
    func login(data: LoginData) {
        
        self.response = .loading
        
        guard let encodedData = try? JSONEncoder().encode(data)
        else {
            print("Failed to encode login request")
            DispatchQueue.main.async {
                self.response = .failure
            }
            return
        }
        
        let url = getBaseURL(Constants.Services.apiLoginPath)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        self.authenticate(request)
        
    }

}


class RegistrationModel: ObservableObject {
    
    @Published var response: Response = .unfetched
    
    
    private func getBaseURL(_ apiPath: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.Services.apiScheme
        components.host = Constants.Services.apiHost
        components.path = apiPath
        return components.url!
    }
    
    
    private func authenticate(_ request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data
            else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.response = .failure
                }
                return
            }
            
            print(response ?? "No response")
            print("Received data:", data)
            print(error ?? "No error")
            
            guard let apiResponse = try? JSONDecoder().decode(User.self, from: data) else {
                print("Failed to decode ADA response")
                DispatchQueue.main.async {
                    self.response = .failure
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        self.response = .success
                        User.setCurrent(apiResponse, writeToUserDefaults: true) // TODO: change to false when other auth method is supplied
                    } else {
                        self.response = .failure
                    }
                }
            }
            
        }.resume()
    }
    
    
    func register(data: RegistrationData) {
        
        self.response = .loading
        
        guard let encodedData = try? JSONEncoder().encode(data)
        else {
            print("Failed to encode registration request")
            DispatchQueue.main.async {
                self.response = .failure
            }
            return
        }
        
        print("Registration JSON:", String(data: encodedData, encoding: .utf8)!)
        
        let url = getBaseURL(Constants.Services.apiRegistrationPath)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        self.authenticate(request)
        
    }
    
}
