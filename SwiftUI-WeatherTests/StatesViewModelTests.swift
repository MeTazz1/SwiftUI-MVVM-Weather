//
//  StatesViewModelTests.swift
//  SwiftUI-WeatherTests
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import XCTest
@testable import SwiftUI_Weather

class StatesViewModelTests: XCTestCase {

    func testInit() throws {
        let viewModel = StatesViewModel()
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.dataSource)
        
        viewModel.initData()
        XCTAssertGreaterThan(viewModel.dataSource.count, 0)
    }
}
