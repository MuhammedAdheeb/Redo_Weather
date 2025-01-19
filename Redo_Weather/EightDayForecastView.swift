//
//  EightDayForecastView.swift
//  Redo_Weather
//
//  Created by user271431 on 1/18/25.
//

import SwiftUI

struct EightDayForecastView: View {
    @ObservedObject var weatherService: WeatherService

    var body: some View {
        VStack(alignment: .leading) {
            let dailyWeather = weatherService.cityData?.weatherDataModel.daily ?? []
            let timezoneOffset = weatherService.cityData?.weatherDataModel.timezoneOffset ?? 0

            // Header
            HStack {
                Image(systemName: "calendar")
                Text("8-DAY FORECAST")
                    .font(.headline)
            }
            .foregroundStyle(.white.opacity(0.5))
            .padding(.bottom, 5)

            // Weather Rows
            ForEach(Array(dailyWeather.enumerated()), id: \.offset) { index, dayWeather in
                let minValue = dayWeather.temp.min
                let maxValue = dayWeather.temp.max
                let icon = getWeatherIcon(dayWeather.weather[0].icon)
                let day = index == 0 ? "Today" : formattedTimeDay(
                    dt: dayWeather.dt,
                    timezoneOffset: timezoneOffset
                )

                DayWeatherRow(day: day, icon: icon, minValue: minValue, maxValue: maxValue)

                // Add divider if not the last element
                if index != dailyWeather.count - 1 {
                    Divider()
                        .background(Color.white.opacity(0.2))
                }
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    func formattedTimeDay(dt: Int, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
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

struct DayWeatherRow: View {
    let day: String
    let icon: String
    let minValue: Double
    let maxValue: Double

    var body: some View {
        HStack {
            HStack {
                Text(day)
                    .frame(width: 80, alignment: .leading)
                    .font(.system(size: 18, weight: .bold))
                Image(systemName: icon)
                    .frame(width: 50)
                    .font(.system(size: 20))
            }
            Spacer()
            HStack {
                Text("\(String(format: "%.0f°", minValue))")
                    .foregroundStyle(.white.opacity(0.5))
                TemperatureGradient()
                Text("\(String(format: "%.0f°", maxValue))")
            }
            .frame(width: 150)
        }
        .padding(.vertical, 8)
    }
}

struct TemperatureGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.green, .yellow, .red]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(height: 8)
        .cornerRadius(4)
    }
}
