import Foundation
import CoreLocation

final class WeatherModel: ObservableObject {
    @Published var weather = Post.empty().list
    @Published var weatherCity = PostCity.empty()
    public var city = "Omsk" {
        didSet {
            getLocationCity()
        }
    }
    
    init() {
            getLocationCity()
    }
    
    private func getLocationCity() {
            CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
                if let places = placemarks,
                   let place = places.first {
                    self.getWeather(coord: place.location?.coordinate)
                    self.getWeatherCity(coord: place.location?.coordinate)
                }
            }
        }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
            var urlString = ""
            if let coord = coord {
                urlString = WeatherApi.getWeatherApi(lat: coord.latitude, lon: coord.longitude)
            } else {
                urlString = WeatherApi.getWeatherApi(lat: 55, lon: 73.24)
            }
            getWeatherInternal(city: city, for: urlString)
        }
    
    private func getWeatherCity(coord: CLLocationCoordinate2D?) {
        var urlString = ""
        if let coord = coord {
            urlString = WeatherApi.getWeatherApiCity(lat: coord.latitude, lon: coord.longitude)
        } else {
            urlString = WeatherApi.getWeatherApiCity(lat: 55, lon: 73.24)
        }
        getWeatherInternalCity(city: city, for: urlString)
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
            guard let url = URL(string: urlString) else {return}
            NetworkManager<Post>.fetchWeather(for: url) { (result) in
                switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.weather = response.list
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    
    private func getWeatherInternalCity(city: String, for urlString: String) {
            guard let url = URL(string: urlString) else {return}
            NetworkManager<PostCity>.fetchWeather(for: url) { (result) in
                switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.weatherCity = response
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    
    func getDay(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "dd"
        let day = format.string(from: date)
        return day
    }
    
    func getHour(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "HH:mm"
        let hour = format.string(from: date)
        return hour
    }
    
    func getDayOfWeek(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }

        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let weekdaySymbols = calendar.weekdaySymbols
        return weekdaySymbols[weekday - 1]
    }
    
    func getHourAndMinute(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let calendar = Calendar.current

        let components = calendar.dateComponents([.hour, .minute], from: date)
        if let _ = components.hour, let _ = components.minute {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            let formattedTime = dateFormatter.string(from: date)
            return formattedTime
        }
        return ""
    }
    
    public func getWeather() -> [Weather]{
        return weather
    }
    
    public func getWeatherCity() -> PostCity {
        return weatherCity
    }
    
    func getWeatherIcon(icon: String) -> String {
            switch icon {
                case "01d":
                    return "sun"
                case "01n":
                    return "moon"
                case "02d":
                    return "cloudSun"
                case "02n":
                    return "cloudMoon"
                case "03d", "04d":
                    return "cloudy"
                case "03n", "04n":
                    return "cloudMoon"
                case "09d", "09n", "10d", "10n":
                    return "rainy"
                case "11d":
                    return "stormDay"
                case "11n":
                    return "stormNight"
                case "13d", "13n":
                    return "snowy"
                case "50d":
                    return "tornadoDay"
                case "50n":
                    return "tornadoNight"
                default:
                    return "sun"
            }
        }
}
