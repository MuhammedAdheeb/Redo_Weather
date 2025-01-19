//
//  AirQualityDataModel.swift
//  Redo_Weather
//
//  Created by user271431 on 1/4/25.
//

import Foundation

import Foundation

struct AirQualityDataModel: Codable {
    let coord: Coord
    let list: [AirList]

   
}

struct Coord: Codable {
    let lon, lat: Double
}


struct AirList: Codable {
    let main: AirMain
    let components: [String: Double]
    let dt: Int
}

struct AirMain: Codable {
    let aqi: Int
}
