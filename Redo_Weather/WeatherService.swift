//
//  WeatherService.swift
//  Redo_Weather
//
//  Created by user271431 on 1/3/25.
//

import Foundation

class WeatherService : ObservableObject {
    //@Published var weatherDataModel : WeatherDataModel?
    @Published var cityData : CityDataModel?
    @Published var airQualityDataModel : AirQualityDataModel?
    let apiKey : String = "11c775dc12a86bafecaffc9fb6bf51f1"
    
    
    func fetchWeather() async {
        var lat: Double = 6.9319
        var lon: Double = 79.8478
        var city: String = "Colombo"
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)") else {
            print("Ivalid URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Invalid response code")
                return
            }
            
            let decodedData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
            
            DispatchQueue.main.async {
                //self.weatherDataModel = decodedData
                self.cityData = CityDataModel(lat: lat, lon: lon, name: city, weatherDataModel: decodedData)
            }
        } catch {
            print("Something went wrong! \(error.localizedDescription)")
        }
    }
    
    func fetchAirQuality() async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=40.7128&lon=-74.0060&appid=\(apiKey)") else {
            print("Ivalid URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Invalid response code")
                return
            }
            
            let decodedData = try JSONDecoder().decode(AirQualityDataModel.self, from: data)
            
            DispatchQueue.main.async {
                self.airQualityDataModel = decodedData
            }
        } catch {
            print("Something went wrong! \(error.localizedDescription)")
        }
    }
    
}

struct CityDataModel {
    var lat, lon : Double
    var name: String
    var weatherDataModel: WeatherDataModel
}
