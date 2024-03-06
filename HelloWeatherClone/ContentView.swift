import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                LocationsView()
                    .tabItem {
                        Label("Locations", image: "location")
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
