//
//  DataFetcher.swift
//  Github Follower VIP
//
//  Created by Ferry Adi Wijayanto on 14/10/21.
//

import Foundation

protocol DataFetcher {
    func getFollower(from username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void)
}

class NetworkDataFetcher: DataFetcher {

    private let service: Services
    
    init(service: Services) {
        self.service = service
    }
    
    func getFollower(from username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        service.request(username, page: page) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let decode = self.decode(jsonData: [Follower].self, from: data) {
                completion(.success(decode))
            }
        }
    }
    
    private func decode<T: Decodable>(jsonData type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data else { return nil }
        let response = try? decoder.decode(type, from: data)
        return response
    }
}
