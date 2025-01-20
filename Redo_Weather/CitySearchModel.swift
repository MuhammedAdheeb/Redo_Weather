//
//  CitySearchModel.swift
//  Redo_Weather
//
//  Created by user271431 on 1/20/25.
//

import Foundation

struct CitySearchResult: Codable, Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}
