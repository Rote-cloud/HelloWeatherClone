import SwiftUI

struct RightNowView: View {
    
    @StateObject var weatherModel: WeatherModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Right now")
                .bold()
                .font(.title)
                .padding(.bottom, -10)
            
            TabView {
                Cloudy(weatherCity: weatherModel.weatherCity)
                
                Param(weatherCity: weatherModel.weatherCity)
            }
            .frame(height: 190)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
        }
        .padding(.vertical)
    }
}

struct Cloudy: View {
    var weatherCity: PostCity
    var iconName: String
    var temp: Int
    var feels_like: Int
    
    init(weatherCity: PostCity) {
        self.weatherCity = weatherCity
        self.iconName = WeatherModel.getWeatherIcon(icon: weatherCity.weather.first!.icon)
        self.temp = Int(weatherCity.main.temp)
        self.feels_like = Int(weatherCity.main.feels_like)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\((iconName.capitalized)) for the hour.")
            
            HStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 120, height: 120)
                VStack {
                    Text("\(temp)&deg;")
                        .font(.system(size: 50))
                        .bold()
                    Text("Feels like \(feels_like)&deg;")
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct Param: View {
    var weatherCity: PostCity
    
    init(weatherCity: PostCity) {
        self.weatherCity = weatherCity
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.purple)
                Text("\(Int(weatherCity.wind.speed))mph winds. Visibility \(weatherCity.visibility)+ meters")
            }
            
            HStack {
                Image("water")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                Text("Humidity \(weatherCity.main.humidity)% &middot; Dewpoint \(Int(weatherCity.main.feels_like))&deg;")
                Spacer()
            }

            HStack {
                Image("sunset")
                    .resizable()
                    .frame(width: 30, height: 30)
                    
                Text("Sunrise \(WeatherModel.getHourAndMinute(time: weatherCity.sys.sunrise)) → Sunset \(WeatherModel.getHourAndMinute(time: weatherCity.sys.sunset)). \(WeatherModel.getDayLight(weatherCity: weatherCity)) hours of daylight")
                Spacer()
            }
            .frame(width: 320)
            
            
            
            Spacer()
        }
        .padding(.top)
    }
}

