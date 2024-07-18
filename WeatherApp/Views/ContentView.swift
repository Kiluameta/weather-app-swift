//
//  ContentView.swift
//  WeatherApp
//
//  Created by Igor Gabriel on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                   WeatherView(weather: weather)
//                    WeatherView()
                } else {
                    ProgressView().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).task{
                        do {
                            print(location.latitude, location.longitude)
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        } catch {
                            print("Something went wrong!")
                        }
                        
                    }
                }
            } else if locationManager.isLoading {
                ProgressView().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            } else {
                HomeView().environmentObject(locationManager)
            }
        }.background(LinearGradient(colors: [Color("light"), Color("dark")], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#Preview {
    ContentView()
}
