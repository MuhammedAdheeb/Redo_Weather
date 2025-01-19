//
//  EightDayForecast.swift
//  Redo_Weather
//
//  Created by user271431 on 1/3/25.
//

import SwiftUI

struct EightDayForecast: View {
    @ObservedObject var weatherService: WeatherService
    
    var body: some View {
        VStack(alignment: .leading) {
            let dailyWeather = weatherService.cityData?.weatherDataModel.daily ?? []
            HStack {
                Image(systemName: "calendar")
                
                Text("8-DAY FORECAST")
                    .font(.headline)
            }
            .foregroundStyle(.white.opacity(0.5))
            .padding(.bottom, 5)
            

        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
    func formattedTimeDay(dt: Int, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        //let adjustedDate = date.addingTimeInterval(TimeInterval(timezoneOffset * 3600))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
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
