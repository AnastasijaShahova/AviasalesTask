//
//  FormatterService.swift
//  AviasalesTestTask
//
//  Created by Шахова Анастасия on 04.09.2024.
//

import Foundation

protocol FormatterServiceProtocol {
    func formatTicketCountMessage(ticketCount: Int) -> String
    func formatFlightDate(from date: Date) -> String
    func formatTime(from date: Date) -> String
    func formatMonth(from date: Date) -> String
    func convertDate(from dateString: String) -> Date?
    func convertToString(from date: Date, format: String) -> String
    func getFormattedPrice(price: String) -> String
}

final class FormatterService: FormatterServiceProtocol {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        return formatter
    }()
    
    // MARK: - Date Formats Enum
    enum DateFormat: String {
        case time = "HH:mm"
        case fullDate = "yyyy-MM-dd HH:mm"
        case month = "d MMMM"
        case day = "d"
        case shortMonth = "MMM"
        case weekDay = "eee"
    }

    // MARK: - Format Ticket Count
    func formatTicketCountMessage(ticketCount: Int) -> String {
        switch ticketCount {
        case 1:
            return "\(ticketCount) билет"
        case 2...4:
            return "\(ticketCount) билета"
        default:
            return "\(ticketCount) билетов"
        }
    }
    
    // MARK: - Format Date and Time
    func formatFlightDate(from date: Date) -> String {
        let day = formatDate(date: date, format: DateFormat.day.rawValue)
        let month = formatDate(date: date, format: DateFormat.shortMonth.rawValue).prefix(3)
        let weekDay = formatDate(date: date, format: DateFormat.weekDay.rawValue).lowercased()
        return "\(day) \(month), \(weekDay)"
    }
    
    func formatTime(from date: Date) -> String {
        formatDate(date: date, format: DateFormat.time.rawValue)
    }
    
    func formatMonth(from date: Date) -> String {
        formatDate(date: date, format: DateFormat.month.rawValue)
    }
    
    func convertDate(from dateString: String) -> Date? {
        formatDate(dateString: dateString, format: DateFormat.fullDate.rawValue)
    }
    
    func convertToString(from date: Date, format: String) -> String {
        formatDate(date: date, format: format)
    }
    
    // MARK: - Format Price
    func getFormattedPrice(price: String) -> String {
        guard let number = Int(price) else { return "" }
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }

    // MARK: - Private Helpers
    private func formatDate(date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    private func formatDate(dateString: String, format: String) -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
}
