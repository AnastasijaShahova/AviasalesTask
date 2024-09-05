//
//  FlightListView.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 02.09.2024.
//

import SwiftUI

struct FlightListView: View {
    @ObservedObject var viewModel: FlightListViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .unset, .loading:
                ProgressView()
            case .error:
                VStack(alignment: .center, spacing: 15) {
                    Spacer()
                    Text("Что-то пошло не так")
                        .font(.headline
                            .weight(.bold))
                    Button("Повторить") {
                        viewModel.loadFlights()
                    }
                    Spacer()
                }
                .padding(40)
            case .loaded(let model):
                FlightListScrollView(model: model, factory: viewModel.flightViewModelFactory)
            }
        }
        .onAppear(perform: {
            viewModel.loadFlights()
        })
    }
}

struct FlightListView_Previews: PreviewProvider {
    static var previews: some View {
        let flightViewModelFactory = FlightViewModelFactory(formatterService: FormatterService())
        FlightListView(viewModel: FlightListViewModel(searchService: FlightSearchService(), flightViewModelFactory: flightViewModelFactory))
    }
}
