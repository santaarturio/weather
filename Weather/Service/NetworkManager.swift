//
//  NetworkManager.swift
//  Weather
//
//  Created by Macbook Pro  on 09.12.2020.
//
import Foundation
import Alamofire

class NetworkManager {
    
    public func request(_ url: URL?, result: @escaping (Data?) -> Void) {
        guard let url = url else { return }
        AF.request(url).validate().response { (afResponse) in
            afResponse.error == nil ?
                result(afResponse.data) : result(nil)
        }
    }
}

//    private let urlManager = UrlManager()
//
//    //MARK: - Public
//    public func getWeather(for cityModel: CityModel,
//                           result: @escaping ((OfferModel?) -> Void)) {
//        if let url = cityModel.coord != nil ?
//            urlManager.createUrlForCoord(cityModel.coord) : urlManager.createUrlForCityName(cityModel.name) {
//            AF.request(url).validate()
//                .responseJSON { (responseJSON) in
//                    guard let data = responseJSON.data else { return }
//                    result(try? JSONDecoder().decode(OfferModel.self, from: data))
//                }
//        }
//    }
//}
