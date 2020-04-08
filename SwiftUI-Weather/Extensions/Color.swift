//
//  Color.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import SwiftUI

extension Color {
    static let sunriseColor = Color.orange
    static let nightColor = Color.blue
    static let dayColor = Color.white
    static let sunsetColor = Color.orange
    
    static var foregroundColor: Color {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 7 && hour <= 19 { return .black }
        return .white
    }
    
    /// Computer themeColor property
    static var themeColor: Color {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0 ... 6: return .nightColor
        case 7 ... 8: return .sunriseColor
        case 8 ... 18: return .dayColor
        case 19 ... 20: return .sunsetColor
        case 21 ... 23: return .nightColor
        default: return .dayColor
        }
    }
}
