import SwiftUI

struct MorningView: View {
    
    @StateObject var weatherModel: WeatherModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("This morning")
                .font(Fonts.titleTextForecast)
            Text("Partly cloudy.")
            
            HStack(alignment: .bottom) {
                ForEach(weatherModel.getOneDayWeather(), id: \.dt) { weather in
                    DiagramView(weather: weather)
                }
                
            }
            .padding(.top, Sizes.paddingBigTop)
        }
    }
}

struct DiagramView: View {
    
    var weather: Weather
    var temp: Double
    var feels_like: Int
    var hour: String
    var iconName: String
    
    init(weather: Weather) {
        self.weather = weather
        self.temp = weather.main.temp
        self.feels_like = Int(weather.main.feels_like)
        self.hour = WeatherModel.getHour(weather: weather)
        self.iconName = WeatherModel.getWeatherIcon(icon: weather.weather.first!.icon)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: Sizes.sizeBaseHistogram, height: Sizes.sizeMinHistogram + (temp > 0 ? temp : 0))
                    .foregroundColor(.blue)
                    .clipShape(
                        RoundCornerShape(rect: CGRect(x: 0, y: 0, width: Sizes.sizeBaseHistogram, height: Sizes.sizeMinHistogram + (temp > 0 ? temp : 0)), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: Sizes.cornerRadius5, height: Sizes.cornerRadius5))
                    )
                VStack {
                    Text("\(Int(temp))&deg;")
                        .foregroundColor(.white)
                        .font(Fonts.subtitleText)
                        .padding(.top, Sizes.paddingSmall)
                    Spacer()
                    Text("\(feels_like)&deg;")
                        .font(Fonts.sizeSmallText)
                        .foregroundColor(.white)
                        .padding(.bottom, Sizes.paddingSmall)
                }
            }

            Text("\(hour)")
                .font(Fonts.sizeSmallText)
            Image("\(iconName)")
                .resizable()
                .frame(width: Sizes.sizeBaseIcon, height: Sizes.sizeBaseIcon)
        }
        .padding(.horizontal, -1)
        .frame(height: Sizes.sizeMinHistogram + (temp > 0 ? temp : 0))
    }
}

