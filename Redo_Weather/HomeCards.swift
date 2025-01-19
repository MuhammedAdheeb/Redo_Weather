//
//  HomeCards.swift
//  Redo_Weather
//
//  Created by user271431 on 1/18/25.
//

import SwiftUI

struct HomeCards: View { 
    
    var value : Int
    var symbol : String
    var title : String
    var description : String
    var icon : String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: icon)
                Text("\(title)            ")
            }
            .foregroundStyle(Color.white.opacity(0.5))
            
            Text("\(value)\(symbol)                              ")
                .font(.largeTitle)
                .padding(.top,1)
            
            Text("\(description)")
            Spacer()
            
        }
        .padding()
        .frame(minWidth: 150, maxWidth: 180, minHeight: 150, maxHeight: 180 ,alignment: .topLeading)
        .foregroundStyle(.white)
        .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    HomeCards(value: 23, symbol: "hPa", title: "Test Card", description: "Overccast Clouds", icon: "cloud.fill" )
}
