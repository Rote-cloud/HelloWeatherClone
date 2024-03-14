import SwiftUI

struct LocationInfo: Identifiable {
    var id = UUID()
    var imageNmae = "text.justify"
    var text: String
    var image2: String?
}

struct LocationsView: View {
    
    @StateObject var weatherModel: WeatherModel
    
    @State private var location = [LocationInfo(imageNmae: "target", text: "Your current location"),
    LocationInfo(text: "New York, New York", image2: "xmark"),
    LocationInfo(text: "Chicago", image2: "xmark"),
    LocationInfo(text: "Moscow", image2: "xmark")]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Locations")
                    .bold()
                    .font(.system(size: 20))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")                        .foregroundColor(.black)
                }
            } 
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            Divider()
            
            ScrollView {
                ForEach(location) { location in
                    Location(weatherModel: weatherModel, location: location) {
                        deleteLoc(location)
                    }
                }
                .onDelete(perform: deleteLocs)

            }
            .navigationTitle("Locations")
            .padding([.bottom, .horizontal])
        }
    }
    
    private func deleteLoc(_ loc: LocationInfo) {
            if let index = location.firstIndex(where: { $0.text == loc.text }) {
                location.remove(at: index)
            }
        }


    private func deleteLocs(at offsets: IndexSet) {
            location.remove(atOffsets: offsets)
        }


}

struct Location: View {
    
    let weatherModel: WeatherModel
    let location: LocationInfo
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Button {
                weatherModel.setCity(city: location.text)
            } label: {
                HStack {
                    Image(systemName: location.imageNmae)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Text(location.text)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Button(action: onDelete)
            {
                if let image = location.image2 {
                    Image(systemName: image)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    LocationsView(weatherModel: WeatherModel())
}
