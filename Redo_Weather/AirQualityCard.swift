//
//  AirQualityCard.swift
//  Redo_Weather
//
//  Created by user271431 on 1/4/25.
//

import SwiftUI

struct AirQualityCard: View {
    @ObservedObject var weatherService : WeatherService
    var body: some View {
        VStack(alignment: .leading) {
            if let components = weatherService.airQualityDataModel?.list.first?.components {
                HStack {
                    Image(systemName: "engine.emission.and.exclamationmark")
                    Text("CURRENT AIR QUALITY")
                }
                .foregroundStyle(Color.white.opacity(0.5))
                HStack {
                    Spacer()
                    if let so2 = components["so2"] {
                        VStack {
                            ZStack {
                                Image(systemName: "smoke.fill")
                                    .resizable()
                                    .frame(width: 50, height: 40)
                                    .scaledToFit()
                                Text("SO₂")
                                    .foregroundStyle(Color.blue.opacity(0.5))
                                    .fontWeight(.bold)
                            }
                            Text("\(so2, specifier: "%.2f")")
                        }
                    }
                    Spacer()
                    if let no2 = components["no2"] {
                        VStack {
                            ZStack {
                                Image(systemName: "smoke.fill")
                                    .resizable()
                                    .frame(width: 50, height: 40)
                                    .scaledToFit()
                                Text("NO₂")
                                    .foregroundStyle(Color.blue.opacity(0.5))
                                    .fontWeight(.bold)
                            }
                            Text("\(no2, specifier: "%.2f")")
                        }
                    }
                    Spacer()
                    if let pm10 = components["pm10"] {
                        VStack {
                            ZStack {
                                Image(systemName: "aqi.low")
                                    .resizable()
                                    .frame(width: 50, height: 40)
                                    .scaledToFit()
                                Text("PM")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            Text("\(pm10, specifier: "%.2f")")
                        }
                    }
                    Spacer()
                    if let co = components["co"] {
                        VStack {
                            ZStack {
                                Image(systemName: "aqi.low")
                                    .resizable()
                                    .frame(width: 50, height: 40)
                                    .scaledToFit()
                                Text("VOC")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            Text("\(co, specifier: "%.2f")")
                        }
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .frame(maxWidth: 370, alignment: .topLeading)
        .foregroundStyle(.white)
        .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 20))
    }
    
}
