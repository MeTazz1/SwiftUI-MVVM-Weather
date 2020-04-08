//
//  DetailsViewModelTests.swift
//  SwiftUI-WeatherTests
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import XCTest
@testable import SwiftUI_Weather

class DetailsViewModelTests: XCTestCase {

    func testInit() throws {
        let viewModelWithExistingState = DetailsViewModel(for: CityInfo(name: "Austin", state: "Texas"),
                                                          in: StateInfo(name: "Texas", abbreviation: "TX"))
        let viewModelWithNonExistingState = DetailsViewModel(for: CityInfo(name: "UnknownTown", state: "Texas"),
                                                          in: StateInfo(name: "Texas", abbreviation: "TX"))

        
        XCTAssertNotNil(viewModelWithExistingState)
        XCTAssertNotNil(viewModelWithExistingState.dataSource)
        XCTAssertNotNil(viewModelWithNonExistingState)
        XCTAssertNotNil(viewModelWithNonExistingState.dataSource)
        
        // Before init, it's default values
        XCTAssertEqual(viewModelWithExistingState.dataSource.name, "")
        XCTAssertEqual(viewModelWithNonExistingState.dataSource.cod, -1)
        
        let expectations = self.expectation(description: "Data")
        
        viewModelWithExistingState.initData()
        viewModelWithNonExistingState.initData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            expectations.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // After init, should be Austin for existing, and -1 for non existing
        XCTAssertEqual(viewModelWithExistingState.dataSource.name, "Austin")
        XCTAssertEqual(viewModelWithNonExistingState.dataSource.cod, -1)

    }
}
