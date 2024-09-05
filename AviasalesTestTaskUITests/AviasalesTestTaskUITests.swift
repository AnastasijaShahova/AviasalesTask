//
//  AviasalesTestTaskUITests.swift
//  AviasalesTestTaskUITests
//
//  Created by Шахова Анастасия on 31.08.2024.
//

import XCTest
@testable import AviasalesTestTask

final class AviasalesTestTaskUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSearchScreenElementsExistence() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.staticTexts["flightDirectionHeading"].exists)
        XCTAssertTrue(app.scrollViews["flightListScroll"].exists)
    }
}
