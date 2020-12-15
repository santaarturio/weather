//
//  ANWeatherTableViewCell.swift
//  Weather
//
//  Created by Macbook Pro  on 10.12.2020.
//

import UIKit

class ANWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humadity: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!

    public func setup(dayName: String?, weatherIcon: UIImage?, humadity: Float?, minTemp: Float?, maxTemp: Float?) {
        self.dayName.text = dayName
        self.weatherIcon.image = weatherIcon
        self.humadity.text = "💧\(String(Int(humadity ?? 50)))%"
        self.minTemp.text = String(Int(minTemp ?? -666))
        self.maxTemp.text = String(Int(maxTemp ?? 666))
    }

}

