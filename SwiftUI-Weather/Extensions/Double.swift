//
//  Double.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation

/// Double extension to add custom behaviors
extension Double {
    
    
    /// Convert the Double value to Fahreinheit
    /// - Returns: a Fahreinheit value in a Int
    func toFahrenheit() -> Int {
        Int(self * 9/5 - 459.67)
    }
    
    /// Convert a Timestamp to a String representation
    /// - Returns: A string representation of the timestamp
    func toTimeString() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        
        return df.string(from: date)
    }
}
