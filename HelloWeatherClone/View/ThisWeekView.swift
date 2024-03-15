import SwiftUI

struct ThisWeekView: View {
    
    var weatherModel: WeatherModel
    var weatherSeveralDays: [Weather]
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
        self.weatherSeveralDays = self.weatherModel.getWeatherSeveralDays()
    }
    
    var body: some View {
        VStack {
            TabView {
                VStack(alignment: .center) {
                    ForEach(weatherSeveralDays, id: \.dt) { weather in
                        DiagramVerticalView(weather: weather)
                    }
                }
                
                VStack(alignment: .center) {
                    ForEach(weatherSeveralDays, id: \.dt) { weather in
                        DiagramVerticalInfo(weather: weather)
                    }
                    Spacer()
                }
                .padding(.top)
            }
            .frame(height: Sizes.thisWeekHeight)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct DiagramVerticalInfo: View {
    
    var weather: Weather
    var iconName: String
    var dayOfWeek: String
    var day: String
    var speed: Int
    
    init(weather: Weather) {
        self.weather = weather
        self.iconName = WeatherModel.getWeatherIcon(icon: self.weather.weather.first!.icon)
        self.dayOfWeek = WeatherModel.getDayOfWeek(weather: weather)
        self.day = WeatherModel.getDay(weather: weather)
        self.speed = Int(weather.wind.speed)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("\(dayOfWeek)")
                    .font(Fonts.sizeMediumText)
                Text("\(day)")
                    .font(Fonts.sizeMediumText)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            Image("\(iconName)")
                .resizable()
                .frame(width: Sizes.sizeBaseIcon, height: Sizes.sizeBaseIcon)
            
            Text("\(iconName.capitalized). \(speed)mph winds.")
        }
    }
}
