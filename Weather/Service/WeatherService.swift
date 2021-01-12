//
//  WeatherService.swift
//  Weather
//
//  Created by Macbook Pro  on 12.01.2021.
//

import Foundation

class WeatherService {
    private let weatherAPI : WeatherAPIProtocol
    
    init() {
        weatherAPI = WeatherAPI()
    }
    
    public func updateWeather(forCity cityModel: CityModel,
                              result: @escaping (OfferModel?) -> Void) {
        if let coord = cityModel.coord {
            weatherAPI.getWeather(byLocation: coord, completion: { (model) in
                result(model)
            })
        } else if let cityName = cityModel.name {
            weatherAPI.getWeather(byCityName: cityName, completion: { (model) in
                result(model)
            })
        }
    }
}
