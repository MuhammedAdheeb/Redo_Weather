//
//  CitySearchViewModel.swift
//  Redo_Weather
//
//  Created by user271431 on 1/20/25.
//

import Foundation

class CitySearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var suggestions: [CitySearchResult] = []
    
    func searchCities() {
        // Basic input validation
        guard searchText.count >= 2 else {
            suggestions = []
            return
        }
        
        // Create URL with API key using HTTPS
        let apiKey = "11c775dc12a86bafecaffc9fb6bf51f1"
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(searchText)&limit=5&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode([CitySearchResult].self, from: data)
                DispatchQueue.main.async {
                    self.suggestions = results
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}
