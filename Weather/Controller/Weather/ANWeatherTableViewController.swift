//
//  ANWeatherTableViewController.swift
//  Weather
//
//  Created by Macbook Pro  on 10.12.2020.
//

import UIKit

class ANWeatherTableViewController: UITableViewController {
    private let dataSource = ANWeatherVcDataSource()
    private let headerIdentifier = String(describing: ANWeatherTableVcTableViewHeader.self)
    private var collectionViewCellIdentifier = String(describing: ANWeatherCollectionViewCell.self)
    private let headerHeight: CGFloat = 135.0
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = self
        setupTableViewHeader()
        setupNavigationBar()
    }
    //MARK: - UISetup
    private func setupTableViewHeader() {
        tableView.register(ANWeatherTableVcTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: headerIdentifier)
    }
    private func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    //MARK: - UIReload
    private func reloadData() {
        tableView.reloadData()
        navigationItem.title = dataSource.getCityName()
    }
    
    //MARK: - TableView Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as? ANWeatherTableVcTableViewHeader else { return nil }
        header.setup()
        header.collectionView.register(ANWeatherCollectionViewCell.self,
                                       forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionViewCellIdentifier = header.collectionViewCellIdentifier
        header.collectionView.dataSource = self
        header.collectionView.delegate = self
        return header
    }
    
    //MARK: - Table View Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.getNumerOfDays()
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerHeight
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        headerHeight * 0.6
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ANWeatherTableViewCell.self)) as? ANWeatherTableViewCell else { return UITableViewCell() }
        if let data = dataSource.getWeatherForCell(at: indexPath.row) {
            cell.setup(dayName: data.dayName,
                       weatherIcon: data.weatherIcon,
                       humadity: data.humadity,
                       minTemp: data.minTemp,
                       maxTemp: data.maxtemp)
        }
        return cell
    }
}

//MARK: - UICollectionViewDataSource
extension ANWeatherTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.getNumberOfPredictions()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier,
                                                            for: indexPath) as? ANWeatherCollectionViewCell
        else { return UICollectionViewCell() }
        if let data = dataSource.getWeatherForItem(at: indexPath.item) {
            cell.setup(time: data.time,
                       weatherIcon: data.weatherIcon,
                       temperature: data.temp)
        }
        return cell
         
//        guard
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier,
//                                                          for: indexPath) as? ANWeatherCollectionViewCell,
//            let data = dataSource.getWeatherForItem(at: indexPath.item)
//        else { return UICollectionViewCell() }
//        cell.setup(time: data.time,
//                   weatherIcon: data.weatherIcon,
//                   temperature: data.temp)
//        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension ANWeatherTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 5,
                      height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UISearchResultsUpdating
extension ANWeatherTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        timer.invalidate()
        guard let city = searchController.searchBar.text, !city.isEmpty else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (_) in
            self.dataSource.updateData(for: city)
            
            searchController.searchBar.text = ""
            searchController.dismiss(animated: true, completion: nil)
        })
    }
}
//MARK: - DataSourceDelegate
extension ANWeatherTableViewController: ANWeatherVcDataSourceDelegate {
    func dataUpdated() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
