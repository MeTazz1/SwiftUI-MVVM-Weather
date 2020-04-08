//
//  WeatherInfo.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct Main: Codable {
    let feels_like: Double
    let humidity: Int
    let pressure: Int
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}

struct Sys: Codable {
    let country: String
    let sunrise: Double
    let sunset: Double
}

struct Weather: Codable {
    let description: String
    let main: String
}

struct Wind: Codable {
    let deg: Int?
    let speed: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct WeatherInfo: Codable, Identifiable {
    /// base
    let id = UUID()
    let name: String
    let cod: Int
    
    /// visibility
    let visibility: Int?
    
    /// coord
    let coord: Coordinates?
    
    /// weather
    let weather: [Weather]?
    
    /// main
    let main: Main?
    
    /// wind
    let wind: Wind?
    
    /// clouds
    let clouds: Clouds?
    
    /// sys
    let sys: Sys?
    
    init() {
        self.name = ""
        self.cod = -1
        
        self.visibility = nil
        self.coord = nil
        self.main = nil
        self.sys = nil
        self.clouds = nil
        self.weather = nil
        self.wind = nil
    }
}
