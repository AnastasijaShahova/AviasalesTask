//
//  HttpClient.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 04.09.2024.
//

import Foundation

enum RequestError: LocalizedError {
    case invalidUrl
    case invalidRequest
    case noData
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidRequest:
            return "Invalid Request"
        case .noData:
            return "No Data Available"
        case .decodingFailed(let error):
            return "Decoding Failed: \(error.localizedDescription)"
        }
    }
}

protocol HTTPClientProtocol {
    func get<T: Decodable>(url: String, parameters: [String: String], completion: @escaping (Result<T, RequestError>) -> Void)
}

final class HTTPClient: HTTPClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func get<T: Decodable>(url: String, parameters: [String: String], completion: @escaping (Result<T, RequestError>) -> Void) {
        guard var urlComponents = URLComponents(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let request = URLRequest(url: finalUrl)
        session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(.decodingFailed(error)))
                    return
                }

                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedData = try self?.decoder.decode(T.self, from: data)
                    if let decodedData {
                        completion(.success(decodedData))
                    } else {
                        completion(.failure(.noData))
                    }
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            }
        }.resume()
    }
}
