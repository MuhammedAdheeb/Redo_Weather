//
//  CityAndCurrentWeatherView.swift
//  Redo_Weather
//
//  Created by user271431 on 1/3/25.
//

import SwiftUI

struct CityAndCurrentWeatherView: View {
    @ObservedObject var weatherService : WeatherService
    let weatherDataModel : WeatherDataModel
    
    var body: some View {
        VStack{
            Text("MY LOCATION")
                .font(.caption)
            Text("\(weatherDataModel.timezone)")
                .font(.largeTitle)
            Text("\(String(format: "%.0f°C", weatherDataModel.current.temp))")
                .font(.system(size: 80))
            
            if let mainWeather = weatherDataModel.current.weather.first?.main {
                Text("\(mainWeather)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.cyan)
            } else {
                Text("Weather data unavailable")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            if let today = weatherDataModel.daily.first {
                Text("L:\(String(format: "%.2f°C", today.temp.min)) H:\(String(format: "%.2f°C", today.temp.max))")
                    .font(.title2)
                    .fontWeight(.bold)
            } else {
                Text("No daily data available")
                    .font(.caption)
            }
        }
        .padding()
        .foregroundStyle(.white)
    }
}


