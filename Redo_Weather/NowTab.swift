//
//  NowTab.swift
//  Redo_Weather
//
//  Created by user271431 on 1/3/25.
//

import SwiftUI

struct NowTab: View {
    @Environment(\.managedObjectContext) var managedObject
    @FetchRequest(sortDescriptors: [
            SortDescriptor(\.name),
            SortDescriptor(\.longitude),
            SortDescriptor(\.latitude)
    ]) var cities: FetchedResults<City>
    @ObservedObject var weatherService : WeatherService
    var body: some View {
        NavigationStack {
            ZStack {
                Image("day")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    VStack {
                        if let weather = weatherService.cityData?.weatherDataModel {
                            CityAndCurrentWeatherView(weatherService: weatherService, weatherDataModel: weather)
                            HourlyForecast(weatherService: weatherService)
                            EightDayForecastView(weatherService: weatherService)
                            HStack {
                                HomeCards(value: Int(weather.current.feelsLike), symbol: "°", title: "FEELS LIKE", description:"", icon: "thermometer")
                                HomeCards(value: weather.current.humidity , symbol: "%", title: "HUMIDITY", description: "", icon: "humidity.fill")
                            }
                            HStack {
                                HomeCards(value:weather.current.pressure, symbol: " hPa", title: "PRESSURE", description: "", icon: "speedometer")
                                HomeCards(value: weather.current.visibility, symbol: " km", title: "VISIBILITY", description: "", icon: "eye.fill")
                            }
                            WindCard(weatherService: weatherService)
                            AirQualityCard(weatherService: weatherService)
                        } else {
                            Text("Loading weather data...")
                                .padding()
                        }
                        
                    }
                    .onAppear {
                        Task {
                            print("fetching weather data")
                            await weatherService.fetchWeather()
                            print("weather data fetched")
                            await weatherService.fetchAirQuality()
                        }
                    }
                    .padding()
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    if let cityName = weatherService.cityData?.name{
                        Button("Add"){
                            let newcity = City(context: managedObject)
                            newcity.name = cityName
                            newcity.latitude = weatherService.cityData?.lat ?? 0
                            newcity.longitude = weatherService.cityData?.lon ?? 0
                            
                            do{
                                try managedObject.save()
                                print("Saved cities Successfully\(cities.count)")
                            } catch {
                                print("Failed to save")
                            }
                            
                        }.foregroundStyle(.white)
                    }
                }
            }
        }
        
    }
}

#Preview {
    NowTab(weatherService: WeatherService())
}
