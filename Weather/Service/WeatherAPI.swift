//
//  WeatherAPI.swift
//  Weather
//
//  Created by Macbook Pro  on 12.01.2021.
//

import Foundation

protocol WeatherAPIProtocol: class {
    func getWeather(byLocation: CoordModel, completion: @escaping WeatherCompletionHandler)
    func getWeather(byCityName: String, completion: @escaping WeatherCompletionHandler)
}

class WeatherAPI: WeatherAPIProtocol {
    private let urlProvider = URLProvider()
    private let networkManager = NetworkManager()
    private let decoder = DataDecoder()
    
    //MARK: - Private
    private func checkResult(_ result: Result<Data?, Error>) -> OfferModel? {
        switch result {
        case .success(let data):
            guard let data = data else { return nil }
            return decoder.decode(from: data,
                                  to: OfferModel.self)
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    //MARK: - Public
    public func getWeather(byLocation coord: CoordModel, completion: @escaping WeatherCompletionHandler) {
        networkManager.request(urlProvider.getURLForCoord(coord)) { [self] (result) in
            completion(checkResult(result))
        }
    }
    public func getWeather(byCityName cityName: String, completion: @escaping WeatherCompletionHandler) {
        networkManager.request(urlProvider.getURLForCityName(cityName)) { [self] (result) in
            completion(checkResult(result))
        }
    }
}
