import SwiftUI

struct LocationsView: View {
    
    @StateObject var weatherModel: WeatherModel
    
    @State private var showModal = false
    @State private var searchValue = ""
    @State private var isCityBool = false
    
    @State private var location = [LocationInfo(imageName: "target", text: "Your current location"),
    LocationInfo(text: "New York, New York", image2: "xmark"),
    LocationInfo(text: "Chicago", image2: "xmark"),
    LocationInfo(text: "Moscow", image2: "xmark")]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Locations")
                    .font(Fonts.titleText)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button {
                    showModal = true
                    searchValue = ""
                } label: {
                    Image(systemName: "plus")                        .foregroundColor(.primary)
                }
                .sheet(isPresented: $showModal, onDismiss: {
                        }) {
                            VStack {
                                HStack {
                                    Button {
                                        showModal = false
                                        isCityBool = false
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .imageScale(.large)
                                    }
                                    TextField("Enter city", text: $searchValue)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                            
                                    Button(action: {
                                        showModal = false
                                        WeatherModel.getSearchCity(city: searchValue, isCity: {isCity in
                                            WeatherModel.getSearchCity(city: searchValue, isCity: {isCity in
                                                isCityBool = !isCity
                                                if isCity == true {
                                                    location.append(LocationInfo(text: searchValue, image2: "xmark"))
                                                }
                                            })
                                        })
                                    }) {
                                        Text("Add City")
                                    }
                                            
                                }
                                .padding()
                                Spacer()
                            }

                        }
            }
            .padding(.horizontal)
            .padding(.bottom, Sizes.paddingSmall)
            
            Divider()
            
            ScrollView {
                ForEach(location) { location in
                    Location(weatherModel: weatherModel, location: location) {
                        deleteLoc(location)
                    }
                }
                .onDelete(perform: deleteLocs)

            }
            .padding([.bottom, .horizontal])
        }
        .alert(isPresented: $isCityBool) {
            Alert(title: Text("Could not find city"), dismissButton: .default(Text("OK")))
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
    
    @EnvironmentObject var tabSelection: TabSelection
    
    let weatherModel: WeatherModel
    let location: LocationInfo
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Button {
                weatherModel.setCity(city: location.text)
                tabSelection.selectedTabIndex = 1
            } label: {
                HStack {
                    Image(systemName: location.imageName)
                        .font(Fonts.sizeImageLocation)
                        .foregroundColor(.primary)
                    Text(location.text)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            
            Button(action: onDelete)
            {
                if let image = location.image2 {
                    Image(systemName: image)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    LocationsView(weatherModel: WeatherModel())
}
