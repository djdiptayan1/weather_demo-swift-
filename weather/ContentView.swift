//
//  ContentView.swift
//  weather
//
//  Created by Diptayan Jash on 13/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()

    @State private var isNight = false
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var temp = 0.0
    let generator = UIImpactFeedbackGenerator(style: .heavy)

    var body: some View {
        ZStack {
//          Color.blue.edgesIgnoringSafeArea()
            background_color(isNight: isNight)

            VStack {
                Text("Current location: \(locationManager.location?.coordinate.latitude ?? 0), \(locationManager.location?.coordinate.longitude ?? 0)")
                if let placemark = locationManager.placemark {
                    city(cityname: "\(placemark.locality ?? ""), \(placemark.country ?? "")")
                } else {
                    city(cityname: "Locating...")
                }

//                city(cityname: "Cupertino, CA")
                Currentweather(weather_img: isNight ? "moon.stars.fill" : "cloud.sun.fill", curr_temp: temp)

                HStack(spacing: 28) {
                    weatherdays(dayofweek: "TUE", imgname: "cloud.sun.fill", temp: 32)
                    weatherdays(dayofweek: "WED", imgname: "sun.max.fill", temp: 21)
                    weatherdays(dayofweek: "THUR", imgname: "sun.snow.fill", temp: 18)
                    weatherdays(dayofweek: "FRI", imgname: "cloud.sun.fill", temp: 34)
                    weatherdays(dayofweek: "SAT", imgname: "cloud.moon.rain.fill", temp: 72)
                }
                .onLongPressGesture(minimumDuration: 2.0) {
                    print("Long Press")
                    generator.impactOccurred()
                    showSheet = true
                }
                .sheet(isPresented: $showSheet) {
                    if let url = URL(string: "https://djdiptayan.in") {
                        SafariView(url: url)
                    } else {
                        Text("Invalid URL")
                    }
                }
                Spacer()

                Slider(value: $temp, in: 0 ... 100, step: 4)
                    .accentColor(.green)
                    .padding()
                    .onReceive([self.temp].publisher.first()) { _ in
                        generator.impactOccurred()
                    }

                Button {
                    generator.impactOccurred()
                    isNight.toggle()
                    print("button pressed")
                } label: {
                    WeatherButton(title: "change", bg_color: isNight ?.white : .blue, fg_color: isNight ? .red : .white)
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
        VStack {
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

struct background_color: View {
    var isNight: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct city: View {
    var cityname: String
    var body: some View {
        Text(cityname)
            .font(.system(size: 32, weight: .medium))
            .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.white)
            .padding()
    }
}

struct Currentweather: View {
    var weather_img: String
    var curr_temp: Double

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: weather_img)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)

            Text(String(format: "%.1f°", curr_temp))
                .font(.system(size: 80, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
