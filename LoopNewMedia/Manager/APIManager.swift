//
//  APIManager.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import Foundation

class APIManager: Task {
    var task: URLSessionDataTask?
    static let shared = APIManager()
     
    private init() {
    }
    
    func fetchData(urlString: String, completion: @escaping ((_ data: Data?, _ error: Error?) -> Void)) -> Task {
        if let url = URL(string: urlString) {
            let req = URLRequest(url: url)
            task = URLSession.shared.dataTask(with: req) { (data, response, error) in
                completion(data,error)
            }
            task?.resume()
        }
        return self
    }
    
    func cancel() {
        task?.cancel()
    }
}
