//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 9.10.22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/users/"
    
    private init() { }
    
    func getFollowers(username: String, page: Int) async throws -> [Follower] {
        let endpoint = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            throw NetworkError.notValidUrl
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse,
           response.statusCode != 200 {
            throw NetworkError.requestFailed
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let followers = try? decoder.decode([Follower].self, from: data) else {
            throw NetworkError.decodingFailed
        }
        
        return followers
    }
}
