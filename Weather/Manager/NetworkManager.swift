//
//  NetworkManager.swift
//  Weather
//
//  Created by Macbook Pro  on 09.12.2020.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let apiKey = "fc54fa89ac9d7ef25bb6222203ec7e7b"
    
    //MARK: - Public
    public func getWeather(for cityModel: CityModel,
                           result: @escaping ((OfferModel?) -> Void)) {
        let url = cityModel.coord != nil ?
            getUrlStringForCoord(cityModel.coord) : getUrlStringForCityName(cityModel.name)
        AF.request(url).validate()
            .responseJSON { (responseJSON) in
                guard let data = responseJSON.data else { return }
                result(try? JSONDecoder().decode(OfferModel.self, from: data))
            }
    }
    
    //MARK: - Private
    private func getUrlStringForCoord(_ coord: CoordModel?) -> String {
        "https://api.openweathermap.org/data/2.5/forecast?" +
            "lat=\(coord?.lat ?? 0)&lon=\(coord?.lon ?? 0)" +
            "&units=metric&lang=ru&appid=\(apiKey)"
    }
    private func getUrlStringForCityName(_ cityName: String?) -> String {
        "https://api.openweathermap.org/data/2.5/forecast?" +
            "q=\(cityName ?? "")" +
            "&units=metric&lang=ru&appid=\(apiKey)"
    }
}
