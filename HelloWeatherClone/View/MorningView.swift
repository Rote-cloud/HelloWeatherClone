import SwiftUI

struct MorningView: View {
    
    @StateObject var weatherModel: WeatherModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("This morning")
                .bold()
                .font(.title)
            Text("Partly cloudy.")
            
            HStack(alignment: .bottom) {
                ForEach(weatherModel.getOneDayWeather(), id: \.dt) { weather in
                    DiagramView(weather: weather)
                }
                
            }
            .padding(.top, 40)
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
                    .frame(width: UIScreen.main.bounds.width / 10, height: 50 + (temp > 0 ? temp : 0))
                    .foregroundColor(.blue)
                    .clipShape(
                        RoundCornerShape(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 10, height: 50 + (temp > 0 ? temp : 0)), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
                    )
                VStack {
                    Text("\(Int(temp))&deg;")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 14))
                        .padding(.top, 5)
                    Spacer()
                    Text("\(feels_like)&deg;")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
            }

            Text("\(hour)")
                .font(.system(size: 12))
            Image("\(iconName)")
                .resizable()
                .frame(width: 35, height: 35)
        }
        .padding(.horizontal, -1)
        .frame(height: 50 + (temp > 0 ? temp : 0))
    }
}

