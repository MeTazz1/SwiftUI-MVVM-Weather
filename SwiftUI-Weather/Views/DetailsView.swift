//
//  DetailsView.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import SwiftUI

extension Double {
    func toFahrenheit() -> Int {
        return Int(self * 9/5 - 459.67)
    }
    
    func toTimeString() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        
        return df.string(from: date)
        
    }
}

extension Color {
    static let sunriseColor = Color.orange
    static let nightColor = Color.blue
    static let dayColor = Color.white
    static let sunsetColor = Color.orange
    
    static var themeColor: Color {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0 ... 6:
            return .nightColor
        case 7 ... 8:
            return .sunriseColor
        case 8 ... 18:
            return .dayColor
        case 19 ... 20:
            return .sunsetColor
        case 21 ... 23:
            return .nightColor
        default:
            return .dayColor
        }
    }
}

struct DetailsView: View {
    
    @ObservedObject var viewModel : DetailsViewModel

    var body: some View {
            VStack(alignment: .center) {
                if self.viewModel.shouldDisplay() {
                    
                   Spacer()
                    
                    VStack {
                        Text("Today, \(self.viewModel.stringDate)\nin \(self.viewModel.city.name), \(self.viewModel.state.abbreviation)")
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 25))
                            .foregroundColor(.themeColor)
                            .shadow(color: .white, radius: 2)
                        
                    }
                    .padding(.top, 20)
                    .padding([.leading, .trailing], 10)
                    
                    VStack {
                        /// Middle View - Information
                        HStack(alignment: .bottom) {
                            Spacer()
                            
                            VStack {
                                Image(systemName: self.viewModel.mainSFSymbol())
                                    .resizable()
                                    .frame(width: 100, height: 90)
                                    .foregroundColor(.themeColor)
                                    .shadow(color: .white, radius: 2)
                                
                            }
                            
                            VStack {
                                Text("\(self.viewModel.dataSource.main!.temp.toFahrenheit())°")
                                    .bold()
                                    .font(Font.system(size: 50))
                                    .foregroundColor(.black)
                                    .shadow(color: .white, radius: 2)
                                
                                Text("feels like \(self.viewModel.dataSource.main!.feels_like.toFahrenheit())°")
                                    .font(Font.system(size: 13))
                                    .foregroundColor(.black)
                                    .shadow(color: .white, radius: 2)
                                
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack(alignment: .bottom) {
                                    Image(systemName: "sunrise")
                                        .resizable()
                                        .frame(width: 35, height: 30)
                                        .foregroundColor(.themeColor)
                                        .shadow(color: .white, radius: 2)
                                    
                                    Text(self.viewModel.dataSource.sys!.sunrise.toTimeString())
                                        .foregroundColor(.black)
                                        .shadow(color: .white, radius: 2)
                                        .font(Font.system(size: 20))
                                    
                                }
                                HStack(alignment: .bottom) {
                                    Image(systemName: "sunset")
                                        .resizable()
                                        .frame(width: 35, height: 30)
                                        .foregroundColor(.nightColor)
                                        .shadow(color: .white, radius: 2)
                                    
                                    Text(self.viewModel.dataSource.sys!.sunset.toTimeString())
                                        .foregroundColor(.black)
                                        .shadow(color: .white, radius: 2)
                                        .font(Font.system(size: 20))
                                    
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    VStack {
                        HStack(alignment: .bottom) {
                            
                            VStack {
                                Image(systemName: "thermometer.sun")
                                    .resizable()
                                    .frame(width: 28, height: 33)
                                    .shadow(color: .white, radius: 2)
                                
                                Text("\(self.viewModel.dataSource.main!.temp_max.toFahrenheit())°")
                                    .shadow(color: .white, radius: 2)
                                Text("max temp")
                                    .font(Font.system(size: 12))
                                .shadow(color: .white, radius: 2)

                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "thermometer.snowflake")
                                    .resizable()
                                    .frame(width: 28, height: 30)
                                    .shadow(color: .white, radius: 2)
                                
                                Text("\(self.viewModel.dataSource.main!.temp_min.toFahrenheit())°")
                                    .shadow(color: .white, radius: 2)
                                Text("min temp")
                                    .font(Font.system(size: 12))
                                .shadow(color: .white, radius: 2)

                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "drop.triangle")
                                    .resizable()
                                    .frame(width: 28, height: 30)
                                    .shadow(color: .white, radius: 2)
                                
                                Text("\(self.viewModel.dataSource.main!.humidity)％")
                                    .shadow(color: .white, radius: 2)
                                Text("humidity")
                                    .font(Font.system(size: 12))
                                .shadow(color: .white, radius: 2)

                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "gauge")
                                    .resizable()
                                    .frame(width: 28, height: 30)
                                    .shadow(color: .white, radius: 2)
                                
                                Text("\(self.viewModel.dataSource.main!.pressure) hPA")
                                    .shadow(color: .white, radius: 2)
                                Text("pressure")
                                    .font(Font.system(size: 12))
                                .shadow(color: .white, radius: 2)

                            }
                            
                            if self.viewModel.dataSource.wind != nil && self.viewModel.dataSource.wind!.speed != nil {
                                Spacer()
                                VStack {
                                    Image(systemName: "wind")
                                        .resizable()
                                        .frame(width: 28, height: 30)
                                        .shadow(color: .white, radius: 2)
                                    
                                    Text("\(String(format: "%.2f", self.viewModel.dataSource.wind!.speed!)) m/s")
                                        .shadow(color: .white, radius: 2)
                                    Text("wind")
                                        .font(Font.system(size: 12))
                                        .shadow(color: .white, radius: 2)
                                    
                                }
                            }
                        }
                    }
                    .padding()
                    .shadow(color: Color.black, radius: 100, x: 0, y: 0)

                    Spacer()
                    
                    VStack {
                        /// Top View - Map
                        MapView(latitude: self.viewModel.dataSource.coord!.lat,
                                longitude: self.viewModel.dataSource.coord!.lon)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .shadow(color: .themeColor, radius: 10, x: 0, y: -10)

                }
            }
            .navigationBarTitle("\(self.viewModel.city.name)", displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .background(
                Image("backgroundSunset")
                    .scaledToFit()
                    .overlay(Color.themeColor.opacity(0.12))
            )
                .onAppear() {
                    self.viewModel.initData()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let state = StateInfo(name: "California", abbreviation: "CA")
    static let city = CityInfo(name: "Los Angeles", state: DetailsView_Previews.state.name)
    
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel(for: DetailsView_Previews.city, in: DetailsView_Previews.state))
    }
}

/*
 message = "city not found";
 }
 The data couldn’t be read because it is missing.
 Value: {
 base = stations;
 clouds =     {
 all = 20;
 };
 cod = 200;
 coord =     {
 lat = "30.27";
 lon = "-97.73999999999999";
 };
 dt = 1586287842;
 id = 4671654;
 main =     {
 "feels_like" = "304.81";
 humidity = 58;
 pressure = 1015;
 temp = "302.73";
 "temp_max" = "304.26";
 "temp_min" = "300.93";
 };
 name = Austin;
 rain =     {
 1h = "0.25";
 };
 sys =     {
 country = US;
 id = 3344;
 sunrise = 1586261528;
 sunset = 1586307196;
 type = 1;
 };
 timezone = "-18000";
 weather =     (
 {
 description = "light rain";
 icon = 10d;
 id = 500;
 main = Rain;
 }
 );
 wind =     {
 speed = "2.6";
 };
 }
 */
