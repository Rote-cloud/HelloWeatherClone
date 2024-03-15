import SwiftUI

struct ContentView: View {
    
    @StateObject private var tabSelection = TabSelection()
    @StateObject var weatherModel = WeatherModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelection.selectedTabIndex) {
                LocationsView(weatherModel: weatherModel)
                    .tabItem {
                        Label("Locations", image: "location")
                    }
                    .tag(0)
                
                Forecast(weatherModel: weatherModel)
                    .tabItem {
                        Label("Forecast", systemImage: "chart.bar.fill")
                    }
                    .tag(1)
                
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .tag(2)
            }
            .environmentObject(tabSelection)

            Divider()
                .padding(.bottom, 65)
        }
    }
}

#Preview {
    ContentView()
}
