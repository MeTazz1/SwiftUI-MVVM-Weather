//
//  NetworkLayer.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation
import Alamofire

/// The network layer used to communicate with OpenWeatherMap API
struct NetworkLayer {
    
    /// The API Url
    #warning("Replace with your API key")
    static let apiURL = "http://api.openweathermap.org/data/2.5/weather?q={CITY},{STATE}&APPID={YOURAPIKEY}"
    
    /// Get the Weather info for the specified place
    /// - Parameters:
    ///   - city: City name
    ///   - state: State name (full)
    ///   - completionHandler: call the completion handler when done loading to return the data
    static func weatherOf(city: String, state: String, completionHandler: @escaping (Data) -> Void) {
        
        var localApi = NetworkLayer.apiURL.replacingOccurrences(of: "{CITY}", with: city)
        localApi = localApi.replacingOccurrences(of: "{STATE}", with: state)
        localApi = localApi.replacingOccurrences(of: " ", with: "")
        
        DispatchQueue.global().async {
            AF.request(localApi).responseJSON { (response) in
                if let error = response.error {
                    print("Error inside weatherOf: \(error.errorDescription ?? " - Default Error description")")
                } else {
                    if let data = response.data {
                        print("Value: \(response.value!)")
                        completionHandler(data)
                    }
                }
            }
        }
    }
}
