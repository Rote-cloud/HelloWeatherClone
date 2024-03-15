import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherModel = WeatherModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                LocationsView(weatherModel: weatherModel)
                    .tabItem {
                        Label("Locations", image: "location")
                    }
                
                Forecast(weatherModel: weatherModel)
                    .tabItem {
                        Label("Forecast", systemImage: "chart.bar.fill")
                    }
                
                
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            Divider()
                .padding(.bottom, 65)
        }
    }
}

#Preview {
    ContentView()
}
