//
//  FlightSearchServiceProtocolMock.swift
//  AviasalesTestTaskTests
//
//  Created by Шахова Анастасия on 05.09.2024.
//

@testable import AviasalesTestTask

final class FlightSearchServiceMock: FlightSearchServiceProtocol {
    
    var invokedFindTickets = false
    var invokedFindTicketsCount = 0
    var invokedFindTicketsParameters: (from: String, to: String)?
    var invokedFindTicketsParametersList = [(from: String, to: String)]()
    var stubbedFindTicketsCompletionResult: Result<FlightSearchResult, AviasalesTestTask.RequestError>?
    
    func findTickets(from: String, to: String, completion: @escaping (Result<FlightSearchResult, AviasalesTestTask.RequestError>) -> Void) {
        invokedFindTickets = true
        invokedFindTicketsCount += 1
        invokedFindTicketsParameters = (from, to)
        invokedFindTicketsParametersList.append((from, to))
        
        if let result = stubbedFindTicketsCompletionResult {
            completion(result)
        }
    }
}
