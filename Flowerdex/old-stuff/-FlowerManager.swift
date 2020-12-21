//
//  Data.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 10/25/20.
//

import Foundation

protocol FlowerManagerDelegate {
    func didUpdateFlowers(flowers: [FlowerModel])
    func didFailWithError(error: Error)
}

struct FlowerManager {
    
    let delegate: FlowerManagerDelegate?
    
    let baseURLString: String = "https://trefle.io/api/v1/plants/search?token=hg6M-l4XhrgVgn2A-qZC6KKMrVPMUuCffVfDgDPtc0I"
    
    func query(_ q: String) {  // &q=amapola
        let urlString = "\(self.baseURLString)&q=\(q)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        print(urlString)
        // Create URL, Create URL Session, Give Session a Task, Start Task
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let flowerData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateFlowers(flowers: flowerData.data!)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> TrefleResponseModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TrefleResponseModel.self, from: data)
            print(decodedData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
