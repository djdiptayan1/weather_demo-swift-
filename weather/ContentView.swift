//
//  ContentView.swift
//  weather
//
//  Created by Diptayan Jash on 13/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
//            Color.blue.edgesIgnoringSafeArea()
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
        
            VStack{
                Text("Cupertino, CA")
                    .font(.system(size: 32, weight: .medium))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.white)
                    .padding()
                
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    
                    Text("76°")
                        .font(.system(size: 80, weight: .medium))
                        .foregroundColor(.white)
                }
                HStack (spacing: 30){
                    weatherdays(dayofweek: "TUE", imgname: "cloud.sun.fill", temp: 32)
                    weatherdays(dayofweek: "WED", imgname: "sun.max.fill", temp: 21)
                    weatherdays(dayofweek: "THUR", imgname: "sun.snow.fill", temp: 18)
                    weatherdays(dayofweek: "FRI", imgname: "cloud.sun.fill", temp: 34)
                    weatherdays(dayofweek: "SAT", imgname: "cloud.sun.fill", temp: 72)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct weatherdays: View {
    var dayofweek: String
    var imgname: String
    var temp: Int
    
    var body: some View {
        VStack{
            Text(dayofweek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imgname)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temp)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
