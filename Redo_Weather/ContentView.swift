//
//  ContentView.swift
//  Redo_Weather
//
//  Created by user271431 on 1/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherService = WeatherService()
    @StateObject var dataController: DataController = DataController()
    var body: some View {
        TabView{
            NowTab(weatherService: weatherService)
                .tabItem{
                    Label("Home", systemImage: "sun.max.fill")
                }
                .environment(\.managedObjectContext, dataController.context.viewContext)
            
            PlacesTab()
                .tabItem{
                    Label("Places", systemImage: "map")
                }
                .environment(\.managedObjectContext, dataController.context.viewContext)
            
            StoredPlacesTab()
                .tabItem{
                    Label("Saved Places", systemImage: "calendar")
                }
                .environment(\.managedObjectContext, dataController.context.viewContext)
        }
    }
}

#Preview {
    ContentView()
}

