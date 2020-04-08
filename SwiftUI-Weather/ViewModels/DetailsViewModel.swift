//
//  DetailsViewModel.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation
import Combine

/// ViewModel for StateView
final class DetailsViewModel: ObservableViewModel<WeatherInfo>  {
    
    /// The selected state
    var city: CityInfo
    var state: StateInfo
    
    var stringDate = ""
    
    /// Initiliaze objet and its properties
    init(for city: CityInfo, in state: StateInfo) {
        self.city = city
        self.state = state
        
        let df = DateFormatter()
        df.dateFormat = "EEEE MMMM yyyy"
        self.stringDate = df.string(from: Date())
        
        super.init(dataSource: WeatherInfo())
    }
    
    /// OS cleaning memory
    deinit {
        self.deinitData()
    }
    
    func shouldDisplay() -> Bool {
        if self.dataSource.main != nil && self.dataSource.coord != nil && self.dataSource.sys != nil {
            return true
        }
        return false
    }
    
    func mainSFSymbol() -> String {
        if let weathers = self.dataSource.weather {
            for weather in weathers {
                print("-------- \(weather.main)")
                switch weather.main {
                case "Clear":
                    return "sun.max"
                case "Clouds":
                    return "cloud"
                case "Rain":
                    return "cloud.drizzle"
                case "Haze":
                    return "sun.haze"
                default:
                    return "sun.min"
                }
            }
        }
        // Clear - clear sky
        // Clouds - few clouds, scattered clouds, broken clouds, overcast clouds
        // Rain - moderate rain, light rain,
        // Haze - haze
        
        
        
        return ""
    }
}

/// StatesViewModel extension for ViewModelDataSource extension
extension DetailsViewModel: ViewModelDataSource {
    
    /// Init the ViewModel data source by reaching JSON file
    func initData() {
        NetworkLayer.weatherOf(city: self.city.name, state: self.state.name, completionHandler: { data in
            let jsonDecoder = JSONDecoder()
            do {
                self.dataSource = try jsonDecoder.decode(WeatherInfo.self, from: data)
                print("dataSource set: \(self.dataSource.name)")
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    /// Unload and deinit ViewModelDataSource
    func deinitData() {
    }
}
