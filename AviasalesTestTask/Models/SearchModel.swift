//
//  SearchModel.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 01.09.2024.
//

import Foundation

struct FlightSearchResult: Codable {
    let passengersCount: Int
    let origin: City
    let destination: City
    let flightInfo: [FlightInfo]
    
    enum CodingKeys: String, CodingKey {
        case passengersCount = "passengers_count"
        case origin
        case destination
        case flightInfo = "results"
    }
}

struct FlightInfo: Codable, Identifiable {
    let id: String
    let departureDateTime: String
    let arrivalDateTime: String
    let price: Price
    let airline: String
    let availableTicketsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case departureDateTime = "departure_date_time"
        case arrivalDateTime = "arrival_date_time"
        case price
        case airline
        case availableTicketsCount = "available_tickets_count"
    }
}

struct City: Codable {
    let iata: String
    let name: String
}

struct Price: Codable {
    let currency: String
    let value: Int
}
