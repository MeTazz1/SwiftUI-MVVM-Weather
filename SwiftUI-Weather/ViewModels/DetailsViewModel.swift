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
    
    /// The selected state & city
    var city: CityInfo
    var state: StateInfo
    
    /// Display date in view
    var stringDate = ""
    
    /// Initiliaze objet and its properties
    /// - Parameters:
    ///   - city: The city to be displayed
    ///   - state: The state to be displayed
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
    
    /// should display the view for the current dataSource
    /// - Returns: a Boolean that specifies if view can be displayed
    func shouldDisplay() -> Bool {
        guard let _ = self.dataSource.main else { return false }
        guard let _ = self.dataSource.coord else { return false }
        guard let _ = self.dataSource.sys else { return false }
        return true
    }
    
    /// Get the right SF Symbol based on the main weather
    /// - Returns: the SF Symbol name to be dispayed
    func mainSFSymbol() -> String {
        guard let weathers = self.dataSource.weather else { return "sun.min" }
        let hour = Calendar.current.component(.hour, from: Date())
      
        for weather in weathers {
            print("-------- \(weather.main)")
            switch weather.main {
            case "Clear":
                if hour >= 7 && hour <= 19 {
                    return "sun.max"
                } else { return "moon" }
                
            case "Clouds":
                if hour >= 7 && hour <= 19 {
                    return "cloud"
                } else { return "cloud.moon" }
            case "Rain":
                if hour >= 7 && hour <= 19 {
                    return "cloud.rain"
                } else { return "cloud.moon.rain" }
            case "Haze":
                return "sun.haze"
            default:
                return "sun.min"
            }
        }
        return "sun.min"
    }
    
    /// Based on weather and daytime, returns the right background image name
    /// - Returns: the background image name
    func mainBackgroundImage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        guard let weathers = self.dataSource.weather else {
            if hour <= 7 || hour >= 19 { return "backgroundNight" }
            return "backgroundSunny"
        }

        if hour <= 7 || hour >= 19 { return "backgroundNight" }
        
        for weather in weathers {
            switch weather.main {
            case "Clear": return "backgroundSunny"
            case "Clouds": return "backgroundCloudy"
            case "Rain": return "backgroundRainy"
            case "Haze": return "backgroundHaze"
            default: return "backgroundSunny"
            }
        }
        return "backgroundSunny"
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
            } catch { print(error.localizedDescription) }
        })
    }
    
    /// Unload and deinit ViewModelDataSource
    func deinitData() { }
}
