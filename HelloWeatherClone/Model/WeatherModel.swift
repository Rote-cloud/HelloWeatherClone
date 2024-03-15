import Foundation
import CoreLocation

final class WeatherModel: ObservableObject {
    @Published var weather = Post.empty().list
    @Published var weatherCity = PostCity.empty()
    private var city = "Omsk" {
        didSet {
            getLocationCity()
        }
    }
    
    init() {
            getLocationCity()
    }
    
    public func setCity(city: String) {
        if city != "Your current location" {
            self.city = city
        } else {
            self.city = "Omsk"
        }
    }
    
    public func getCity() -> String {
        return city
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
    
    func getOneDayWeather() -> [Weather] {
        var arrayWeather: [Weather] = []
        
        for index in 0..<8 {
                if index < weather.count {
                    arrayWeather.append(weather[index])
                }
            }
        
        return arrayWeather
    }
    
    func getWeatherSeveralDays() -> [Weather] {
        var arrayWeather: [Weather] = []
        
        if !weather.isEmpty {
            var nowDay = WeatherModel.getDay(weather: weather.first!)
            
            for w in weather {
                let day = WeatherModel.getDay(weather: w)
                if day != nowDay && WeatherModel.getHour(weather: w) == "12pm"  {
                    arrayWeather.append(w)
                    nowDay = day
                }
            }
        }
        
        return arrayWeather
    }
    
    func getHighTemp() -> Int {
        if !weather.isEmpty {
            let arrayWeather = self.getWeatherSeveralDays()
            var temp = 0
            for w in arrayWeather {
                temp = max(temp, Int(w.main.temp))
            }
            
            return temp
        }
        
        return 0
    }
    
    static func getSearchCity(city: String, isCity: @escaping (Bool) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(city) { (placemarks, error) in
            var cityBool = false
            
            if error == nil {
                if let places = placemarks?.first, let _ = places.locality ?? places.administrativeArea {
                    cityBool = true
                }
            }
            isCity(cityBool)
        }
    }
    
    static func nowNight(time: PostCity) -> Bool {
        let date = Int(Date().timeIntervalSince1970)
        
        return date >= time.sys.sunset || date < time.sys.sunrise
    }
    
    static func getBadWeatherPercent(weather: Weather) -> Int {
        if let snow = weather.snow?.values.first {
            return Int(snow * 100)
        }
        if let rain = weather.rain?.values.first {
            return Int(rain * 100)
        }
        
        return 0
    }
    
    static func getDay(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "dd"
        let day = format.string(from: date)
        return day
    }
    
    static func getHour(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "ha"
        let hour = format.string(from: date)
        return hour.lowercased()
    }
    
    static func getDayOfWeek(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "E"
        let dayOfWeek = format.string(from: date)
        return dayOfWeek.uppercased()
    }
    
    static func getHourAndMinute(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let calendar = Calendar.current

        let components = calendar.dateComponents([.hour, .minute], from: date)
        if let _ = components.hour, let _ = components.minute {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mma"
            
            let formattedTime = dateFormatter.string(from: date)
            return formattedTime.lowercased()
        }
        return ""
    }
    
    static func getDayLight(weatherCity: PostCity) -> String {
        let time = weatherCity.sys.sunset - weatherCity.sys.sunrise
        return "\(time / 3600):\(time % 3600 / 60)"
    }
    
    static func getWeatherIcon(icon: String) -> String {
            switch icon {
                case "01d":
                    return "sun"
                case "01n":
                    return "moon"
                case "02d", "03d", "04d":
                    return "cloudy"
                case "02n", "03n", "04n":
                    return "cloudMoon"
                case "09d", "10d":
                    return "rainy"
                case "09n", "10n":
                    return "rainyNight"
                case "11d":
                    return "stormDay"
                case "11n":
                    return "stormNight"
                case "13d":
                    return "snowy"
                case "13n":
                    return "snowyNight"
                default:
                    return "sun"
            }
        }
}
