//
//  ANWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Macbook Pro  on 11.12.2020.
//

import UIKit
import TinyConstraints

class ANWeatherCollectionViewCell: UICollectionViewCell {
    private var timeLabel = UILabel()
    private var weatherIcon = UIImageView()
    private var tempLabel = UILabel()
    
    public func setup(time: String?, weatherIcon image: UIImage?, temperature temp: Float?) {
        configureView()
        timeLabel.text = time
        weatherIcon.image = image
        tempLabel.text = "\(Int(temp ?? 666))°C"
    }
    private func configureView() {
        backgroundColor = .clear
        
        timeLabel.textAlignment = .center
        addSubview(timeLabel)
        timeLabel.edgesToSuperview(excluding: .bottom, insets: .top(4.0))
        timeLabel.heightToSuperview(multiplier: 0.2)
        
        weatherIcon.contentMode = .scaleAspectFit
        addSubview(weatherIcon)
        weatherIcon.topToBottom(of: timeLabel)
        weatherIcon.leftToSuperview()
        weatherIcon.rightToSuperview()
        
        tempLabel.textAlignment = .center
        addSubview(tempLabel)
        tempLabel.topToBottom(of: weatherIcon)
        tempLabel.edgesToSuperview(excluding: .top, insets: .bottom(4.0))
        tempLabel.height(to: timeLabel)
    }
}
