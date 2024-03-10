import SwiftUI

private struct ViewRectKey: PreferenceKey {
   static let defaultValue: CGSize = .zero
   static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
      value = nextValue()
   }
}

struct Forecast: View {
    
    @StateObject var weatherModel: WeatherModel = WeatherModel()
        
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Moscow, Russia")
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("share")
                        .frame(width: 10, height: 10)
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .foregroundColor(.blue)
            
            Divider()
                .overlay(.blue)
                .padding(.horizontal)
            
            ScrollView {
                RightNow(weatherModel: weatherModel)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct RightNow: View {
    
    @StateObject var weatherModel: WeatherModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Right now")
                .bold()
                .font(.title)
                .padding(.bottom, -10)
            
            TabView {
                VStack(alignment: .leading) {
                    Text("Cloudy for the hour.")
                    
                    HStack {
                        Image("cloudy")
                            .resizable()
                            .frame(width: 120, height: 120)
                        VStack {
                            Text("\(Int(weatherModel.weatherCity.main.temp))&deg;")
                                .font(.system(size: 50))
                                .bold()
                            Text("Feels like 25&deg;")
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                //.frame(height: 200)
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image("water")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                        Text("Humidity 56% Dewpoint 33&deg; Feels dry.")
                        Spacer()
                    }
                    .frame(width: 320)
                    //.padding(.leading, -35)

                    HStack {
                        Image("sunset")
                            .resizable()
                            .frame(width: 40, height: 40)
                            
                        Text("Sunrise 6:18am → Sunset 5:55pm. 11.6 hours of daylight")
                        Spacer()
                    }
                    //.frame(width: 320)
                    //.padding(.leading, -20)
                }
                .frame(height: 300)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            //.frame(minHeight: 180, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .fixedSize(horizontal: false, vertical: false)
            .frame(minHeight: 180, maxHeight: .infinity)
            //.toolbarBackground(.hidden, for: .tabBar)
            //.frame(height: 180)
            
        }
        .padding(.vertical)
    }
}

#Preview {
    Forecast()
}
