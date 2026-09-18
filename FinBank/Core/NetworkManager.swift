//
//  NetworkManager.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError(code: Int)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverError(let code):
            return "Error de servidor (\(code))."
        case .decodingError:
            return "Failed to decode response"
        }
    }
}

protocol NetworkManagerProtocol {
    func request<T: Decodable>(urlString: String) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw NetworkError.serverError(code: code)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
