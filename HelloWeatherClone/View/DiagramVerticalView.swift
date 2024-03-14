import SwiftUI

struct DiagramVerticalView: View {
    
    var weather: Weather
    var badWeather: Int
    var temp: Double
    var iconName: String
    var dayOfWeek: String
    var day: String
    var feels_like: Int
    
    init(weather: Weather) {
        self.weather = weather
        self.badWeather = WeatherModel.getBadWeatherPercent(weather: self.weather)
        self.temp = self.weather.main.temp
        self.iconName = WeatherModel.getWeatherIcon(icon: weather.weather.first!.icon)
        self.dayOfWeek = WeatherModel.getDayOfWeek(weather: weather)
        self.day = WeatherModel.getDay(weather: weather)
        self.feels_like = Int(weather.main.feels_like)
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                Rectangle()
                    .frame(width: badWeather > 0 ? CGFloat(85 + badWeather) : 0, height: UIScreen.main.bounds.width / 10)
                    .foregroundColor(.blue)
                    .clipShape(
                        RoundCornerShape(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 10, height: (badWeather > 0 ? CGFloat(85 + badWeather) : 0)), byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
                    )
                HStack {
                    if badWeather != 0 {
                        Text("\(badWeather)%")
                            .foregroundColor(.white)
                            .bold()
                            .padding(.leading, 5)
                    }
                    
                    Spacer()
                    
                    Image("\(iconName)")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
            }
            .frame(width: badWeather > 0 ? CGFloat(85 + badWeather) : 35)
            
            VStack(alignment: .center) {
                Text("\(dayOfWeek)")
                    .font(.system(size: 14))
                Text("\(day)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 65 + (temp > 0 ? temp : 0), height: UIScreen.main.bounds.width / 10)
                    .foregroundColor(.blue)
                    .clipShape(
                        RoundCornerShape(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 10, height: 65 + (temp > 0 ? temp : 0)), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5))
                    )
                HStack {
                    Text("\(feels_like)&deg;")
                        .foregroundColor(.white)
                        .frame(width: 40, height: UIScreen.main.bounds.width / 10)
                        .background(Color(red: 2 / 255, green: 140 / 255, blue: 1))
                        .bold()
                    Spacer()
                    Text("\(Int(temp))&deg;")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.trailing, 5)
                }
                .frame(width: 65 + (temp > 0 ? temp : 0))
            }
        }
        .position(x: UIScreen.main.bounds.width / 2 - (badWeather > 0 ? CGFloat(badWeather) : 0))
        .frame(height: UIScreen.main.bounds.width / 10 - 4)
    }
}
