import SwiftUI

struct Forecast: View {
    
    @StateObject var weatherModel: WeatherModel = WeatherModel()
        
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text(weatherModel.getCity())
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
                RightNowView(weatherModel: weatherModel)
                
                Button {
                    
                } label: {
                    VStack {
                        Text("Get real-time rainfall info!")
                        Text("Join the Hello Weather fan club →")
                    }
                    .padding(5)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .buttonStyle(.bordered)
                .background(.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                MorningView(weatherModel: weatherModel)
                
                VStack(alignment: .leading) {
                    Text("This week")
                        .bold()
                        .font(.title)
                    Text("Cloudy for the new few days, with a high of \(weatherModel.getHighTemp())&deg;")
                }
                .padding(.top, 40)
                
                ThisWeekView(weatherModel: weatherModel)
                
                Button {
                    
                } label: {
                    Text("Apple Weather + Auto [Feels Like]")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
                
                Button {
                    
                } label: {
                    Text("About this data")
                        .underline(true)
                }
                .padding(.top)
                .padding(.bottom, 50)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    Forecast()
}
