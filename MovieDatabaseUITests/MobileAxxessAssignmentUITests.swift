//
//  MovieDatabaseUITests.swift
//  MovieDatabaseUITests
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright © 2020 Celerstudio. All rights reserved.
//

import XCTest

class MovieDatabaseUITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
