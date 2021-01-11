//
//  NetworkManager.swift
//  Weather
//
//  Created by Macbook Pro  on 09.12.2020.
//

import Alamofire

class NetworkManager {
    private let urlManager = UrlManager()
    
    //MARK: - Public
    public func getWeather(for cityModel: CityModel,
                           result: @escaping ((OfferModel?) -> Void)) {
        if let url = cityModel.coord != nil ?
            urlManager.createUrlForCoord(cityModel.coord) : urlManager.createUrlForCityName(cityModel.name) {
            AF.request(url).validate()
                .responseJSON { (responseJSON) in
                    guard let data = responseJSON.data else { return }
                    result(try? JSONDecoder().decode(OfferModel.self, from: data))
                }
        }
    }
}
