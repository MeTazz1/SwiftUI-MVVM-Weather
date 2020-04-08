//
//  CitiesViewModelTests.swift
//  SwiftUI-WeatherTests
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import XCTest
@testable import SwiftUI_Weather

class CitiesViewModelTests: XCTestCase {

    func testInit() throws {
        let viewModelWithExistingState = CitiesViewModel(for: StateInfo(name: "Texas", abbreviation: "TX"))
        let viewModelWithNonExistingState = CitiesViewModel(for: StateInfo(name: "Unknown", abbreviation: ""))

        XCTAssertNotNil(viewModelWithExistingState)
        XCTAssertNotNil(viewModelWithExistingState.dataSource)
        XCTAssertNotNil(viewModelWithNonExistingState)
        XCTAssertNotNil(viewModelWithNonExistingState.dataSource)
        
        viewModelWithExistingState.initData()
        viewModelWithNonExistingState.initData()
                
        XCTAssertGreaterThan(viewModelWithExistingState.dataSource.count, 0)
        XCTAssertEqual(viewModelWithNonExistingState.dataSource.count, 0)

    }
}
