//
//  AviasalesTestTaskApp.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 31.08.2024.
//

import SwiftUI

@main
struct AviasalesApp: App {
    var body: some Scene {
        WindowGroup {
            let flightViewModelFactory = FlightViewModelFactory(formatterService: FormatterService())
            FlightListView(viewModel: FlightListViewModel(searchService: FlightSearchService(), flightViewModelFactory: flightViewModelFactory))
        }
    }
}
