//
//  NetworkService.swift
//  Github Follower VIP
//
//  Created by Ferry Adi Wijayanto on 13/10/21.
//

import Foundation

protocol Services {
    func request(_ username: String, page: Int, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class NetworkService: Services {
    
    private let baseURL = "https://api.github.com/"
    
    func request(_ username: String, page: Int, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let endpoint = baseURL + "users/\(username)/followers?per_page=100&page=\(page)"
        print(endpoint)
        guard let url = URL(string: endpoint) else { return }
        
        let task = createTask(url: url, completion: completion)
        task.resume()
    }
    
    private func createTask(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async { completion(data, response, error) }
        }
    }
    
    
}
