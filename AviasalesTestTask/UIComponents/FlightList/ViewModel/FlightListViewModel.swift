//
//  FlightListViewModel.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import Foundation

enum AirportCode: String {
    case moscow = "MOW"
    case saintPetersburg = "LED"
}

final class FlightListViewModel: ObservableObject {
    private let searchService: FlightSearchServiceProtocol
    let flightViewModelFactory: FlightViewModelFactoryProtocol
    
    enum State {
        case unset
        case loading
        case error(String)
        case loaded(FlightListScrollModel)
    }
    
    @Published var state: State = .unset
    
    init(searchService: FlightSearchServiceProtocol, flightViewModelFactory: FlightViewModelFactoryProtocol) {
        self.searchService = searchService
        self.flightViewModelFactory = flightViewModelFactory
    }
    
    func loadFlights() {
        state = .loading
        searchService.findTickets(from: AirportCode.moscow.rawValue, to: AirportCode.saintPetersburg.rawValue) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let flightSearchResult):
                    let scrollModel = self.flightViewModelFactory.createFlightListScrollModel(from: flightSearchResult)
                    self.state = .loaded(scrollModel)
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
