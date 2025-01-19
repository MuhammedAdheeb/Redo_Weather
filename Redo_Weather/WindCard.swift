//
//  WindCard.swift
//  Redo_Weather
//
//  Created by user271431 on 1/18/25.
//

import SwiftUI

struct WindCard: View {
    @ObservedObject var weatherService: WeatherService
    var body: some View {
        VStack(alignment: .leading){
            if let weather = weatherService.cityData?.weatherDataModel {
                HStack{
                    Image(systemName: "wind")
                    Text("WIND")
                }
                .foregroundStyle(Color.white.opacity(0.5))
                
                HStack{
                    VStack {
                        HStack{
                            Text("Wind")
                                .font(.headline)
                            
                            Spacer()
                            Text("\(String(format: "%.0f km/h", weather.current.windSpeed))")
                                .foregroundStyle(Color.white.opacity(0.5))
                            
                        }
                        .padding(2)
                        Divider()
                        
                        HStack{
                            Text("Gusts")
                                .font(.headline)
                            Spacer()
                            if let windGust = weather.current.windGust{
                                Text("\(String(format: "%.0f km/h", windGust))")
                                    .foregroundStyle(Color.white.opacity(0.5))
                            } else {
                                Text("-")
                            }
                            
                        }
                        .padding(2)
                        Divider()
                        
                        HStack{
                            Text("Direction")
                                .font(.headline)
                            Spacer()
                            Text("\(weather.current.windDeg)°")
                                .foregroundStyle(Color.white.opacity(0.5))
                        }
                        .padding(2)
                    }
                    .frame(minWidth:200)
                    
                    Spacer()
                    
                    ZStack{
                        Circle()
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 120, height: 120)
                        
                        // Basic cardinal points
                        Text("N").offset(y: -45)
                        Text("E").offset(x: 45)
                        Text("S").offset(y: 45)
                        Text("W").offset(x: -45)
                        // Simple arrow
                        
                        ZStack {
                            Image("windArrow")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(Double(weather.current.windDeg)))
                            Text("\(String(format: "%.0f km/h", weather.current.windSpeed))")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                                .padding(.top, 8)
                        }
                    }
                }
            }
            
        }
        .padding()
        .frame(maxWidth: 370, alignment: .topLeading)
        .foregroundStyle(.white)
        .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 20))

    }
}

