//
//  HourlyForecast.swift
//  Redo_Weather
//
//  Created by user271431 on 1/4/25.
//

import SwiftUI

struct HourlyForecast: View {
    @ObservedObject var weatherService: WeatherService
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                let hourlyWeather = weatherService.cityData?.weatherDataModel.hourly ?? []
                
                ForEach(Array(hourlyWeather.enumerated()), id: \.offset){index, hourWeather in
                    let day: String = index == 0 ? "Now" : formattedHourlyTime(dt: hourWeather.dt, timezoneOffset: weatherService.cityData?.weatherDataModel.timezoneOffset ?? 0)
                    let temp : Double = hourWeather.temp
                    let icon : String = getWeatherIcon(hourWeather.weather[0].icon)
                    VStack {
                        Text("\(day)")
                        Spacer()
                        Image(systemName: icon)
                        Spacer()
                        Text("\(String(format:"%.0f",temp))")
                            .font(.system(size: 18, weight: .bold))
                    }
                    .frame(minWidth: 60, maxWidth: 60, minHeight: 100, maxHeight: 100 ,alignment: .topLeading)
                }
            }
        }
        .padding()
        .foregroundStyle(.white)
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func formattedHourlyTime(dt: Int, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        // let adjustedDate = date.addingTimeInterval(TimeInterval(timezoneOffset * 3600))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
        return formatter.string(from: date)
    }
    private func getWeatherIcon(_ code: String) -> String {
        switch code {
        case "01d", "01n": return "sun.max.fill"
        case "02d", "02n": return "cloud.sun.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "cloud.fill"
        case "09d", "09n": return "cloud.rain.fill"
        case "10d", "10n": return "cloud.sun.rain.fill"
        case "11d", "11n": return "cloud.bolt.rain.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "cloud.fill"
        }
    }
}

