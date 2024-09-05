//
//  FlightViewModelFactory.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 05.09.2024.
//

import Foundation

protocol FlightViewModelFactoryProtocol {
    func createFlightListScrollModel(from flightSearchResult: FlightSearchResult) -> FlightListScrollModel
    func createFlightDetailsModel(from flightListCellModel: FlightListCellModel) -> FlightDetailsModel
}

final class FlightViewModelFactory: FlightViewModelFactoryProtocol {
    private let formatterService: FormatterServiceProtocol
    
    init(formatterService: FormatterServiceProtocol) {
        self.formatterService = formatterService
    }
    
    // MARK: - Create FlightListScrollModel
    func createFlightListScrollModel(from flightSearchResult: FlightSearchResult) -> FlightListScrollModel {
        let sortedTickets = flightSearchResult.flightInfo.sorted { $0.price.value < $1.price.value }
        let formattedDate = formatDepartureDate(from: sortedTickets.first?.departureDateTime ?? "")
        
        let headerModel = createHeaderModel(origin: flightSearchResult.origin.name,
                                            destination: flightSearchResult.destination.name,
                                            formattedDate: formattedDate,
                                            passengersCount: flightSearchResult.passengersCount
        )
        
        let cellModels = sortedTickets.enumerated().map { index, ticket in
            createFlightListCellModel(from: ticket, isCheapest: index == 0, origin: flightSearchResult.origin, destination: flightSearchResult.destination, passengersCount: flightSearchResult.passengersCount)
        }
        
        return FlightListScrollModel(cellModels: cellModels, headerModel: headerModel)
    }
    
    private func formatDepartureDate(from departureDateTime: String) -> String {
        let departureDate = formatterService.convertDate(from: departureDateTime) ?? Date()
        return formatterService.formatMonth(from: departureDate)
    }
    
    private func createHeaderModel(origin: String, destination: String, formattedDate: String, passengersCount: Int) -> TitleSubtitleModel {
        let title = "\(origin) — \(destination)"
        let subtitle = "\(formattedDate), \(passengersCount) чел"
        
        return TitleSubtitleModel(title: title, subtitle: subtitle, alignment: .center)
    }
    
    private func createFlightListCellModel(from flightInfo: FlightInfo, isCheapest: Bool, origin: City, destination: City, passengersCount: Int) -> FlightListCellModel {
        let price = formatterService.getFormattedPrice(price: String(flightInfo.price.value))
        let formatCountMessage = formatterService.formatTicketCountMessage(ticketCount: flightInfo.availableTicketsCount)
        let warningTitle = flightInfo.availableTicketsCount < 10 ? "Осталось \(formatCountMessage) по этой цене" : nil
        let infoModel = createInfoPairModel(from: flightInfo, origin: origin, destination: destination)

        return FlightListCellModel(id: flightInfo.id, headerModel: FlightInfoCellHeaderModel(price: price,
                                                                                         companyName: flightInfo.airline,
                                                                                         warningTitle: warningTitle
                                                                                        ),
                                   infoModel: infoModel,
                                   isCheapest: isCheapest,
                                   passengersCount: passengersCount
        )
    }
    
    private func formatFlightInfo(from dateTime: String) -> (time: String, fullDate: String) {
        let dateObject = formatterService.convertDate(from: dateTime) ?? Date()
        let time = formatterService.formatTime(from: dateObject)
        let fullDate = formatterService.formatFlightDate(from: dateObject)
        return (time, fullDate)
    }
    
    private func createInfoPairModel(from flightInfo: FlightInfo, origin: City, destination: City) -> InfoPairModel {
        let departureInfo = formatFlightInfo(from: flightInfo.departureDateTime)
        let arrivalInfo = formatFlightInfo(from: flightInfo.arrivalDateTime)
        
        return InfoPairModel(
            pairs: [
                TitleSubtitlePair(
                    leftModel: TitleSubtitleModel(title: origin.name, subtitle: origin.iata, alignment: .leading),
                    rightModel: TitleSubtitleModel(title: departureInfo.time, subtitle: departureInfo.fullDate, alignment: .trailing)
                ),
                TitleSubtitlePair(
                    leftModel: TitleSubtitleModel(title: destination.name, subtitle: destination.iata, alignment: .leading),
                    rightModel: TitleSubtitleModel(title: arrivalInfo.time, subtitle: arrivalInfo.fullDate, alignment: .trailing)
                )
            ]
        )
    }
        
    // MARK: - Create FlightListScrollModel
    func createFlightDetailsModel(from flightListCellModel: FlightListCellModel) -> FlightDetailsModel {
        let price = flightListCellModel.headerModel.price
        let companyName = flightListCellModel.headerModel.companyName
        
        let buttonModel = FlightDetailsButtonModel(
            buttonTitle: "Купить билет за \(price)",
            alertMessage: "Билет куплен за \(price)"
        )
        
        let headerModel = PriceHeaderModel(price: price, passengersCount: "Лучшая цена за \(flightListCellModel.passengersCount) чел")
        let informationModel = FlightInfoCellModel(companyName: companyName, ticketDetailsModel: flightListCellModel.infoModel)
        
        let title = "\(flightListCellModel.infoModel.pairs.first?.leftModel.title ?? "") — \(flightListCellModel.infoModel.pairs.last?.leftModel.title ?? "")"
        
        return FlightDetailsModel(buttonModel: buttonModel, headerModel: headerModel, informationModel: informationModel, title: title)
    }
}
