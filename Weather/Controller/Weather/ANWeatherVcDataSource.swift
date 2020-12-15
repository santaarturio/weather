//
//  ANWeatherVcDataSource.swift
//  Weather
//
//  Created by Macbook Pro  on 10.12.2020.
//

import Foundation
import UIKit
protocol  ANWeatherVcDataSourceDelegate: class {
    func dataUpdated()
}
class ANWeatherVcDataSource {
    public weak var delegate: ANWeatherVcDataSourceDelegate?
    private let manager = NetworkManager.shared
    private let numberOfDays = 5
    private let numberOfPredictionsPerDay = 8
    private var weatherModel: OfferModel? {
        didSet { delegate?.dataUpdated() }
    }
    private var weatherIconsDict = [String: UIImage?]()
    private var weatherIcon: UIImage?
    
    //MARK: - Private
    private func getWeekDay(at index: Int) -> String {
        var date = Date()
        date.addTimeInterval(TimeInterval((index + 1) * 3600 * 24))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    private func getTimeDescription(from date: String?) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        let newDate = dateFormatterGet.date(from: date ?? "")
        return dateFormatterPrint.string(from: newDate ?? Date())
    }
    //MARK: - Needs Roma Help
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
//    private func downloadImage(from url: URL) -> UIImage? {
//        var image: UIImage?
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.sync() {
//                image = UIImage(data: data)
//
//            }
//        }
//        return image
//    }
    private func getWeatherIcon(code iconCode: String) -> UIImage? {
        if weatherIconsDict[iconCode] != nil { return weatherIconsDict[iconCode] ?? UIImage() }
        guard let url = URL(string: "https://openweathermap.org/img/w/\(iconCode).png") else { return nil }
        var image: UIImage?
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            image = UIImage(data: data)
            self.weatherIconsDict.updateValue(image, forKey: iconCode)
            self.delegate?.dataUpdated()
        }
        return weatherIconsDict[iconCode] ?? UIImage()
    }
    //MARK: - Update
    public func updateData(for city: String) {
        manager.getWeather(for: city) { [self] (data) in
            guard let data = data else { return }
            weatherModel = data
        }
    }
    //MARK: - Get for CollectionView
    public func getNumberOfPredictions() -> Int {
        numberOfPredictionsPerDay
    }
    public func getWeatherForItem(at index: Int)
    -> (time: String?, weatherIcon: UIImage?, temp: Float?)? {
        guard let list = weatherModel?.list else { return nil }
        let offerModel = list[index]
        let dtText = offerModel.dt_txt
        let weatherIconCode = offerModel.weather?[0].icon
        let temp = offerModel.main?.temp
        return (time: getTimeDescription(from: dtText),
                weatherIcon: getWeatherIcon(code: weatherIconCode ?? "10d"),
                temp: temp)
    }
    
    //MARK: - Get for TableView
    public func getNumerOfDays() -> Int {
        numberOfDays
    }
    public func getWeatherForCell(at index: Int)
    -> (dayName: String?, weatherIcon: UIImage?, humadity: Float?, minTemp: Float?, maxtemp: Float?)? {
        let index = (index + 1) * 8 - 1
        guard let list = weatherModel?.list else { return nil }
        let offerModel = list[index]
        let weatherIconCode = offerModel.weather?[0].icon
        let humadity = offerModel.main?.humidity
        let minTemp = offerModel.main?.temp_min
        let maxTemp = offerModel.main?.temp_max
        return (dayName: getWeekDay(at: index),
                weatherIcon: getWeatherIcon(code: weatherIconCode ?? "10d"),
                humadity: humadity,
                minTemp: minTemp,
                maxtemp: maxTemp)
    }
    public func getCityName() -> String {
        weatherModel?.city?.name ?? "--"
    }
    public func getCountryName() -> String {
        weatherModel?.city?.country ?? "--"
    }
}

