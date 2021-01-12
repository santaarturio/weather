//
//  URLProvider.swift
//  Weather
//
//  Created by Macbook Pro  on 12.01.2021.
//

import Foundation

class URLProvider {
    //MARK: - Private Properties
    private var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [URLQueryItem(name: "units", value: "metric"),
                                 URLQueryItem(name: "lang",  value: "ru"),
                                 URLQueryItem(name: "appid", value: "fc54fa89ac9d7ef25bb6222203ec7e7b")]
        return components
    }()
    
    //MARK: - Private Methods
    private func urlComponentsConfiguredWith(_ qItemsArray: [URLQueryItem]) -> URLComponents {
        var components = urlComponents
        var qItems = components.queryItems
        qItems?.insert(contentsOf: qItemsArray,
                       at: components.queryItems?.startIndex ?? 0)
        components.queryItems = qItems
        return components
    }
    private func configuredURLComponents(forCityName cityName: String) -> URLComponents {
        urlComponentsConfiguredWith([URLQueryItem(name: "q", value: cityName)])
    }
    private func configuredURLComponents(forCoord coord: CoordModel) -> URLComponents {
        urlComponentsConfiguredWith([URLQueryItem(name: "lat", value: "\(coord.lat ?? 0)"),
                                     URLQueryItem(name: "lon", value: "\(coord.lon ?? 0)")])
    }
    
    //MARK: - Public Methods
    public func getURLForCoord(_ coord: CoordModel) -> URL? {
        configuredURLComponents(forCoord: coord).url
    }
    public func getURLForCityName(_ cityName: String) -> URL? {
        configuredURLComponents(forCityName: cityName).url
    }
}
