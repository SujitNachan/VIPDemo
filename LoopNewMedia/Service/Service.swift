//
//  Service.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import Foundation

struct ResponeModel {
    let movies: [Movie]?
}

protocol Task {
    func cancel()
}

protocol ServiceProtocol {
    func fetchData(urlString:String, completion: @escaping (Result<ResponeModel, Error>) -> Void) -> Task
}

class HomeService: ServiceProtocol {
    func fetchData(urlString: String, completion: @escaping (Result<ResponeModel, Error>) -> Void) -> Task {
        let task = APIManager.shared.fetchData(urlString: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let movies = try JSONDecoder().decode([Movie].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(ResponeModel(movies: movies)))
                    }
                    
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        return task
    }
}
