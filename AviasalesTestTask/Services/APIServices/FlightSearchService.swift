//
//  FlightSearchService.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 04.09.2024.
//

import Foundation

protocol FlightSearchServiceProtocol {
    func findTickets(from: String, to: String, completion: @escaping (Result<FlightSearchResult, RequestError>) -> Void)
}

final class FlightSearchService: FlightSearchServiceProtocol {
    private let httpClient: HTTPClientProtocol
    private let baseURL: String
    
    init(httpClient: HTTPClientProtocol = HTTPClient(), baseURL: String = "https://nu.vsepoka.ru/api/search") {
        self.httpClient = httpClient
        self.baseURL = baseURL
    }
    
    func findTickets(from: String, to: String, completion: @escaping (Result<FlightSearchResult, RequestError>) -> Void) {
        let parameters = ["origin": from, "destination": to]
        httpClient.get(url: baseURL, parameters: parameters, completion: completion)
    }
}
