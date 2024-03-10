import Foundation


struct Post: Codable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [Weather]
    
    static func empty() -> Post {
            Post(cod: "", message: 0, cnt: 0, list: [Weather()])
        }
}

struct Weather: Codable {
    var dt: Int
    var main: TodayWeather
    var weather: [WeatherIcon]
    var clouds: WeatherClouds?
    var wind: WeatherWind
    var visibility: Int
    var pop: Double
    var rain: [String: Double]?
    var sys: WeatherPod
    var dt_txt: String
    
    init() {
        dt = 0
        main = TodayWeather()
        weather = [WeatherIcon()]
        //clouds = WeatherClouds()
        wind = WeatherWind()
        visibility = 0
        pop = 0
        //rain = ["3h" : 0]
        sys = WeatherPod()
        dt_txt = ""
    }
    
    func getParam() -> [String: Double] {
        var dict: [String: Double] = [:]
        dict["temp"] = main.temp
        dict["feels_like"] = main.feels_like
        dict["speed"] = wind.speed
        dict["visibility"] = Double(visibility)
        dict["humidity"] = Double(main.humidity)
        
        return dict
    }
}

struct TodayWeather: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var sea_level: Int
    var grnd_level: Int
    var humidity: Int
    var temp_kf: Double
    
    init() {
        temp = 0
        feels_like = 0
        temp_min = 0
        temp_max = 0
        pressure = 0
        sea_level = 0
        grnd_level = 0
        humidity = 0
        temp_kf = 0
    }
}

struct WeatherIcon: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
}

struct WeatherClouds: Codable {
    var all: Int
    
    init() {
        all = 0
    }
}

struct WeatherWind: Codable {
    var speed: Double
    var deg: Double
    var gust: Double?
    
    init() {
        speed = 0
        deg = 0
        //gust = 0
    }
}

struct WeatherPod: Codable {
    var pod: String
    
    init() {
        pod = ""
    }
}

struct AverageWeather: Codable {
    var temp: Double
    var feels_like: Double
    var speed: Double
    var icon: String
    var visibility: Int
    var humidity: Int
    
    init() {
        temp = 0
        feels_like = 0
        speed = 0
        icon = ""
        visibility = 0
        humidity = 0
    }
}
