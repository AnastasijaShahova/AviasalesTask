//
//  AviasalesTestTaskTests.swift
//  AviasalesTestTaskTests
//
//  Created by Шахова Анастасия on 31.08.2024.
//

import XCTest
@testable import AviasalesTestTask

final class AviasalesTestTaskTests: XCTestCase {
    
    private var flightSearchService: FlightSearchServiceMock!
    private var httpClient: HTTPClientMock!
    private var flightListViewModel: FlightListViewModel!
    private var formatterService: FormatterServiceProtocol!
    
    override func setUpWithError() throws {
        httpClient = HTTPClientMock()
        flightSearchService = FlightSearchServiceMock()
        formatterService = FormatterService()
        let factory = FlightViewModelFactory(formatterService: formatterService)
        flightListViewModel = FlightListViewModel(searchService: flightSearchService, flightViewModelFactory: factory)
    }
    
    override func tearDownWithError() throws {
        httpClient = nil
        flightSearchService = nil
        flightListViewModel = nil
    }
    
    func testLoadFlightsSuccess() throws {
        let mockFlightSearchResult = FlightSearchResult(
            passengersCount: 1,
            origin: City(iata: "MOW", name: "Москва"),
            destination: City(iata: "LED", name: "Санкт-Петербург"),
            flightInfo: [
                FlightInfo(id: "1", departureDateTime: "2024-09-05 10:00", arrivalDateTime: "2024-09-05 12:00", price: Price(currency: "RUB", value: 1000), airline: "Аэрофлот", availableTicketsCount: 5)
            ]
        )
        
        flightSearchService.stubbedFindTicketsCompletionResult = .success(mockFlightSearchResult)
        
        let expectation = XCTestExpectation(description: "Load flights successfully")
        
        flightListViewModel.loadFlights()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.flightSearchService.invokedFindTickets, "FindTickets should be invoked")
            
            if case .loaded(let flightListScrollModel) = self.flightListViewModel.state {
                XCTAssertEqual(flightListScrollModel.cellModels.count, 1, "There should be 1 flight in the list")
                
                let cellModel = flightListScrollModel.cellModels.first

                XCTAssertEqual(cellModel?.headerModel.price, "1 000 ₽", "Price should be correctly formatted")
                XCTAssertEqual(cellModel?.headerModel.companyName, "Аэрофлот", "Airline name should be 'Аэрофлот'")
                XCTAssertEqual(flightListScrollModel.headerModel.title, "Москва — Санкт-Петербург", "Header title should match the flight route")
                
                expectation.fulfill()
            } else {
                XCTFail("Expected state to be .loaded")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadFlightsFailure() throws {
        let mockError = RequestError.invalidRequest
        flightSearchService.stubbedFindTicketsCompletionResult = .failure(mockError)
        
        let expectation = XCTestExpectation(description: "Load flights failure")
        
        flightListViewModel.loadFlights()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.flightSearchService.invokedFindTickets, "FindTickets should be invoked")
            
            if case .error(let errorMessage) = self.flightListViewModel.state {
                XCTAssertEqual(errorMessage, mockError.localizedDescription, "Error message should match the localized description of the error")
                
                expectation.fulfill()
            } else {
                XCTFail("Expected state to be .error with message: \(mockError.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testHTTPClientGetSuccess() throws {
        let mockData = try JSONEncoder().encode(FlightSearchResult(
            passengersCount: 1,
            origin: City(iata: "MOW", name: "Москва"),
            destination: City(iata: "LED", name: "Санкт-Петербург"),
            flightInfo: [
                FlightInfo(id: "1", departureDateTime: "2024-09-05 10:00", arrivalDateTime: "2024-09-05 12:00", price: Price(currency: "RUB", value: 1000), airline: "Аэрофлот", availableTicketsCount: 5)
            ]
        ))
        httpClient.stubbedGetCompletionResult = .success(mockData)
        
        var result: Result<FlightSearchResult, AviasalesTestTask.RequestError>?
        httpClient.get(url: "https://test-url.com", parameters: [:]) { (response: Result<FlightSearchResult, AviasalesTestTask.RequestError>) in
            result = response
        }
        
        XCTAssertTrue(httpClient.invokedGet)
        XCTAssertNotNil(result)
        switch result {
        case .success(let data):
            XCTAssertEqual(data.passengersCount, 1)
            XCTAssertEqual(data.origin.name, "Москва")
        case .failure:
            XCTFail("Ожидался успех, но произошла ошибка")
        default:
            XCTFail("Результат запроса не был обработан")
        }
    }
    
    func testFormatTicketCountMessage() {
        XCTAssertEqual(formatterService.formatTicketCountMessage(ticketCount: 1), "1 билет")
        XCTAssertEqual(formatterService.formatTicketCountMessage(ticketCount: 2), "2 билета")
        XCTAssertEqual(formatterService.formatTicketCountMessage(ticketCount: 5), "5 билетов")
    }
    
    func testFormatFlightDate() {
        let date = Date(timeIntervalSince1970: 1693603200)
        let formattedDate = formatterService.formatFlightDate(from: date)
        XCTAssertEqual(formattedDate, "2 сен, сб")
    }
    
    func testFormatTime() {
        let date = Date(timeIntervalSince1970: 1693603200)
        let formattedTime = formatterService.formatTime(from: date)
        XCTAssertEqual(formattedTime, "00:20")
    }
    
    func testFormatMonth() {
        let date = Date(timeIntervalSince1970: 1693603200)
        let formattedMonth = formatterService.formatMonth(from: date)
        XCTAssertEqual(formattedMonth, "2 сентября")
    }
    
    func testConvertDate() {
        let dateString = "2023-09-01 12:34"
        let date = formatterService.convertDate(from: dateString)
        XCTAssertNotNil(date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 9)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 12)
        XCTAssertEqual(components.minute, 34)
    }
    
    func testConvertToString() {
        let date = Date(timeIntervalSince1970: 1693603200)
        let dateString = formatterService.convertToString(from: date, format: "yyyy-MM-dd HH:mm")
        XCTAssertEqual(dateString, "2023-09-02 00:20")
    }
    
    func testGetFormattedPrice() {
        XCTAssertEqual(formatterService.getFormattedPrice(price: "15000"), "15 000 ₽")
        XCTAssertEqual(formatterService.getFormattedPrice(price: "2000"), "2 000 ₽")
        XCTAssertEqual(formatterService.getFormattedPrice(price: "abc"), "")
    }
}
