//
//  ANWeatherTableVcTableViewHeader.swift
//  Weather
//
//  Created by Macbook Pro  on 11.12.2020.
//

import UIKit
import Hex
import TinyConstraints

class ANWeatherTableVcTableViewHeader: UITableViewHeaderFooterView {
    public var collectionView = UICollectionView(frame: CGRect(),
                                                 collectionViewLayout: UICollectionViewFlowLayout())
    public let collectionViewCellIdentifier = String(describing: ANWeatherCollectionViewCell.self)
    
    public func setup() {
        configureView()
        configureCollectionView()
    }
    private func configureView() {
        backgroundView = UIView()
        backgroundView?.layer.borderColor = UIColor.systemGray4.cgColor
        backgroundView?.layer.borderWidth = 0.5
        backgroundView?.backgroundColor = UIColor(hex: "E9FFFF")
    }
    private func configureCollectionView() {
        if self.subviews.contains(collectionView) { collectionView.removeFromSuperview() }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(),
                                          collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ANWeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: collectionViewCellIdentifier)
        addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.backgroundColor = .clear
    }
}
