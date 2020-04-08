//
//  CityInfo.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation

struct CityInfo: Codable, Identifiable {
    let id = UUID()
    let name: String
    let state: String
}
