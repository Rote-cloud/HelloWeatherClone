import Foundation


struct PostCity: Codable {
    var coord: WeatherCoord
    var weather: [WeatherIcon]
    var base: String
    var main: WeatherCity
    var visibility: Int
    var wind: WeatherWind
    var rain: [String: Double]?
    var clouds: WeatherClouds?
    var dt: Int
    var sys: WeatherSys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    static func empty() -> PostCity {
        PostCity(coord: WeatherCoord(), weather: [WeatherIcon()], base: "", main: WeatherCity(), visibility: 0, wind: WeatherWind(), dt: 0, sys: WeatherSys(), timezone: 0, id: 0, name: "", cod: 0)
        }
}

struct WeatherCity: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    var sea_level: Int?
    var grnd_level: Int?
    
    init() {
        temp = 0
        feels_like = 0
        temp_min = 0
        temp_max = 0
        pressure = 0
        humidity = 0
        //sea_level = 0
        //grnd_level = 0
    }
}

struct WeatherCoord: Codable {
    var lon: Double
    var lat: Double
    
    init() {
        lon = 0
        lat = 0
    }
}

struct WeatherSys: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
    
    init() {
        type = 0
        id = 0
        country = ""
        sunrise = 0
        sunset = 0
    }
}
