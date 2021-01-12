//
//  WeatherService.swift
//  Weather
//
//  Created by Macbook Pro  on 12.01.2021.
//

import Foundation

public typealias WeatherCompletionHandler = (OfferModel?) -> Void

public enum Parameter {
    case CityName, Location
}

class WeatherService {
    private let weatherAPI: WeatherAPIProtocol
    
    init(weatherAPI: WeatherAPIProtocol) {
        self.weatherAPI = weatherAPI
    }
    
    public func updateWeather(forCity cityModel: CityModel,
                              by parameter: Parameter,
                              result: @escaping WeatherCompletionHandler) {
        switch parameter {
        case .CityName:
            if let cityName = cityModel.name {
                weatherAPI.getWeather(byCityName: cityName, completion: { (model) in
                    result(model)
                }) }
        case .Location:
            if let coord = cityModel.coord {
                weatherAPI.getWeather(byLocation: coord, completion: { (model) in
                    result(model)
                }) }
        }
    }
}
