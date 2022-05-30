//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

struct RepositoryService {
    private var allReposCancellable: AnyCancellable?
    
    mutating func getAllReposOf(_ username: String, completion: @escaping (Result<[Repo], Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            completion(.failure(StringError("Wrong URL")))
            return
        }
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        // MARK: - Non-Combine
        //        session.dataTask(with: url) { data, _, error in
        //            if let error = error {
        //                completion(.failure(error))
        //            }
        //
        //            guard let data = data else {
        //                completion(.failure(StringError("Unable to get data")))
        //                return
        //            }
        //
        //            do {
        //                decoder.keyDecodingStrategy = .convertFromSnakeCase
        //
        //                let repos = try decoder.decode([Repo].self, from: data)
        //                completion(.success(repos))
        //            } catch {
        //                completion(.failure(error))
        //            }
        //
        //        }.resume()
        
        
        // MARK: - Combine
        allReposCancellable?.cancel()
        
        let publisher = session.dataTaskPublisher(for: url)
            .map { data, response in
                data
            }
            .decode(type: [Repo].self, decoder: decoder)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
        
        allReposCancellable = publisher
            .sink { repos in
                if !repos.isEmpty {
                    completion(.success(repos))
                }
            }
    }
}

struct StringError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}
