//
//  WeatherButton.swift
//  weather
//
//  Created by Diptayan Jash on 18/12/23.
//
import SwiftUI
import Foundation


struct WeatherButton: View {
    var title:String
    var bg_color: Color
    var fg_color: Color
    
    var body: some View {
        Text(title)
            .frame(width: 180, height: 50)
            .background(bg_color.gradient)
            .foregroundColor(fg_color)
            .font(.system(size: 20, weight: .bold))
            .cornerRadius(10)
    }
}

#Preview {
    WeatherButton(title: "change", bg_color: .white, fg_color: .red)
}
