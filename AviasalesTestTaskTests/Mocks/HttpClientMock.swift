//
//  HttpClientMock.swift
//  AviasalesTestTaskTests
//
//  Created by Шахова Анастасия on 05.09.2024.
//

import Foundation
@testable import AviasalesTestTask

final class HTTPClientMock: HTTPClientProtocol {    
    var invokedGet = false
    var invokedGetCount = 0
    var invokedGetParameters: (url: String, parameters: [String: String])?
    var invokedGetParametersList = [(url: String, parameters: [String: String])]()
    var stubbedGetCompletionResult: (Result<Data, Error>)?
    
    func get<T: Decodable>(url: String, parameters: [String: String], completion: @escaping (Result<T, RequestError>) -> Void) {
        invokedGet = true
        invokedGetCount += 1
        invokedGetParameters = (url, parameters)
        invokedGetParametersList.append((url, parameters))
        
        if let result = stubbedGetCompletionResult {
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            case .failure(let error):
                if let requestError = error as? RequestError {
                    completion(.failure(requestError))
                } else {
                    completion(.failure(.decodingFailed(error)))
                }
            }
        }
    }
}
