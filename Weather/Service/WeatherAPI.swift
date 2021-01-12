//
//  WeatherAPI.swift
//  Weather
//
//  Created by Macbook Pro  on 12.01.2021.
//

import Foundation

protocol WeatherAPIProtocol: class {
    func getWeather(byLocation: CoordModel, completion: @escaping (OfferModel?) -> Void)
    func getWeather(byCityName: String, completion: @escaping (OfferModel?) -> Void)
}

class WeatherAPI: WeatherAPIProtocol {
    private let urlProvider = URLProvider()
    private let networkManager = NetworkManager()
    private let decoder = DataDecoder()
    
    func getWeather(byLocation coord: CoordModel, completion: @escaping (OfferModel?) -> Void) {
        networkManager.request(urlProvider.getURLForCoord(coord)) { [self] (data) in
            if let data = data {
                completion( decoder.decodeJSON(from: data,
                                               to: OfferModel.self)) }
        }
    }
    func getWeather(byCityName cityName: String, completion: @escaping (OfferModel?) -> Void) {
        networkManager.request(urlProvider.getURLForCityName(cityName)) { [self] (data) in
            if let data = data {
                completion( decoder.decodeJSON(from: data,
                                               to: OfferModel.self)) }
        }
    }
}
