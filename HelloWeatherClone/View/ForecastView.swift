import SwiftUI

struct Forecast: View {
    
    @StateObject var weatherModel: WeatherModel
        
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text(weatherModel.getCity())
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("share")
                        .frame(width: Sizes.sizeSmallImage, height: Sizes.sizeSmallImage)
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
                    .padding(Sizes.paddingSmall)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .buttonStyle(.bordered)
                .background(.purple)
                .foregroundColor(.white)
                .cornerRadius(Sizes.cornerRadius10)
                
                MorningView(weatherModel: weatherModel)
                
                VStack(alignment: .leading) {
                    Text("This week")
                        .font(Fonts.titleTextForecast)
                    Text("Cloudy for the new few days, with a high of \(weatherModel.getHighTemp())&deg;")
                }
                .padding(.top, Sizes.paddingBigTop)
                
                ThisWeekView(weatherModel: weatherModel)
                
                Button {
                    
                } label: {
                    Text("Apple Weather + Auto [Feels Like]")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: Sizes.cornerRadius10)
                        .stroke(.blue, lineWidth: 1)
                )
                
                Button {
                    
                } label: {
                    Text("About this data")
                        .underline(true)
                }
                .padding(.top)
                .padding(.bottom, Sizes.paddingBigBottom)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    Forecast(weatherModel: WeatherModel())
}
