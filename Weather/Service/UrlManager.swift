//
//  UrlManager.swift
//  Weather
//
//  Created by Macbook Pro  on 11.01.2021.
//

import Foundation

class UrlManager {
    private let urlFormatForCoord = "https://api.openweathermap.org/data/2.5/forecast?" +
        "lat=%@&lon=%@" +
        "&units=metric&lang=ru&appid=%@"
    private let urlFormatForCityName = "https://api.openweathermap.org/data/2.5/forecast?" +
        "q=%@" +
        "&units=metric&lang=ru&appid=%@"
    private let apiKey = "fc54fa89ac9d7ef25bb6222203ec7e7b"
    
    //MARK: - Public 
    public func createUrlForCoord(_ coord: CoordModel?) -> URL? {
        guard let coord = coord else { return nil }
        let urlString = String(format: urlFormatForCoord, "\(coord.lat ?? 0)", "\(coord.lon ?? 0)", apiKey)
        return URL(string: urlString)
    }
    public func createUrlForCityName(_ cityName: String?) -> URL? {
        guard let cityName = cityName else { return nil }
        let urlString = String(format: urlFormatForCityName, cityName, apiKey)
        return URL(string: urlString)
    }
}
