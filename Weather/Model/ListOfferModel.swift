//
//  ListOfferModel.swift
//  Weather
//
//  Created by Macbook Pro  on 09.12.2020.
//

import Foundation

public class ListOfferModel: Codable {
    var main: MainOfferModel?
    var weather: [WeatherModel]?
    var wind: WindModel?
    var dt_txt: String?
}
