//
//  NetworkManager.swift
//  Weather
//
//  Created by Macbook Pro  on 09.12.2020.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let apiKey = "fc54fa89ac9d7ef25bb6222203ec7e7b"
    private let units = "metric"
    private let language = "ru"
    
    public func getWeather(for city: String, result: @escaping((OfferModel?) -> ())) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: units),
                                    //URLQueryItem(name: "lang", value: language),
                                    URLQueryItem(name: "appid", value: apiKey)]
        guard let requestURL = urlComponents.url else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            var decodedOfferModel: OfferModel?
            decodedOfferModel = try? decoder.decode(OfferModel.self, from: data)
            result(decodedOfferModel)
        }.resume()
        //chould to add new url method
    }
}


