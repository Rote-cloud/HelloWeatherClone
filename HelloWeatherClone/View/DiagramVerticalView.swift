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
                    .frame(width: badWeather > 0 ? CGFloat(Sizes.sizeBadWeather + badWeather) : 0, height: Sizes.sizeBaseHistogram)
                    .foregroundColor(Color("blues"))
                    .clipShape(
                        RoundCornerShape(rect: CGRect(x: 0, y: 0, width: Sizes.sizeBaseHistogram, height: (badWeather > 0 ? CGFloat(Sizes.sizeBadWeather + badWeather) : 0)), byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: Sizes.cornerRadius5, height: Sizes.cornerRadius5))
                    )
                HStack {
                    if badWeather != 0 {
                        Text("\(badWeather)%")
                            .foregroundColor(Color("histoColor"))
                            .font(Fonts.boldText)
                            .padding(.leading, Sizes.paddingSmall)
                    }
                    
                    Spacer()
                    
                    Image("\(iconName)")
                        .resizable()
                        .frame(width: Sizes.sizeBaseIcon, height: Sizes.sizeBaseIcon)
                }
            }
            .frame(width: badWeather > 0 ? CGFloat(Sizes.sizeBadWeather + badWeather) : Sizes.sizeBaseIcon)
            
            VStack(alignment: .center) {
                Text("\(dayOfWeek)")
                    .font(Fonts.sizeMediumText)
                Text("\(day)")
                    .font(Fonts.sizeSmallText)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: Double(Sizes.sizeBadWeather) + (temp > 0 ? temp : 0), height: Sizes.sizeBaseHistogram)
                    .foregroundColor(Color("blues"))
                    .clipShape(
                        RoundCornerShape(rect: CGRect(x: 0, y: 0, width: Sizes.sizeBaseHistogram, height: Double(Sizes.sizeBadWeather) + (temp > 0 ? temp : 0)), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: Sizes.cornerRadius5, height: Sizes.cornerRadius5))
                    )
                HStack {
                    Text("\(feels_like)&deg;")
                        .foregroundColor(Color("histoColor"))
                        .font(Fonts.boldText)
                        .frame(width: Sizes.sizeBaseHistogram, height: Sizes.sizeBaseHistogram)
                        .background(Color("lightBlue"))
                    Spacer()
                    Text("\(Int(temp))&deg;")
                        .foregroundColor(Color("histoColor"))
                        .font(Fonts.boldText)
                        .padding(.trailing, Sizes.paddingSmall)
                }
                .frame(width: Double(Sizes.sizeBadWeather) + (temp > 0 ? temp : 0))
            }
        }
        .position(x: Sizes.centerXPosition - (badWeather > 0 ? CGFloat(badWeather) : 0))
        .frame(height: Sizes.sizeBaseHistogram - 4)
    }
}
