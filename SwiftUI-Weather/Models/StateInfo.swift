//
//  State.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation

struct StateInfo: Codable, Identifiable {
    let id = UUID()
    let name: String
    let abbreviation: String
}
