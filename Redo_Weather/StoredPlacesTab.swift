//
//  StoredPlacesTab.swift
//  Redo_Weather
//
//  Created by user271431 on 1/3/25.
//

import SwiftUI

struct StoredPlacesTab: View {
    @Environment(\.managedObjectContext) var managedObject
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.longitude),
        SortDescriptor(\.latitude)
    ]) var cities: FetchedResults<City>
    
    @StateObject private var viewModel = CitySearchViewModel()
    @State private var showSuggestions = false
    
    var body: some View {
        VStack {
            // Search bar
            TextField("Search city...", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: viewModel.searchText) { oldValue, newValue in
                    viewModel.searchCities()
                    showSuggestions = true
                }
            
            // Suggestions list
            if showSuggestions && !viewModel.suggestions.isEmpty {
                List(viewModel.suggestions) { suggestion in
                    Button(action: {
                        addCity(suggestion)
                        showSuggestions = false
                        viewModel.searchText = ""
                    }) {
                        Text("\(suggestion.name), \(suggestion.country)")
                    }
                }
                .frame(height: min(CGFloat(viewModel.suggestions.count * 44), 200))
            }
            
            // Stored cities list
            List(cities) { city in
                if let cityName = city.name {
                    Text(cityName)
                }
            }
        }
    }
    
    // Function to add city to CoreData
    private func addCity(_ suggestion: CitySearchResult) {
        let newCity = City(context: managedObject)
        newCity.name = "\(suggestion.name), \(suggestion.country)"
        newCity.latitude = suggestion.lat
        newCity.longitude = suggestion.lon
        
        do {
            try managedObject.save()
        } catch {
            print("Error saving city: \(error)")
        }
    }
}
