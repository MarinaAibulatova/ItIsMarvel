//
//  MarvelItemViewController.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 07.07.2021.
//

import UIKit

class MarvelItemViewController: UIViewController, MarvelCharacterManagerDelegate{

    //MARK: - Variables
    var marvelItem: CharacterResult?
    var marvelManager = MarvelCharacterManager()
    var seriesTable: UITableView!
    
    var series: [Series] = []
    let marvelItemView = MarvelItemView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let marvelItemView = MarvelItemView()
        marvelItemView.seriesTableView.delegate = self
        marvelItemView.seriesTableView.dataSource = self
        marvelItemView.seriesTableView.prefetchDataSource = self
        
        self.view.addSubview(marvelItemView.mainView)
        setMarvelViewConstraints(for: marvelItemView.mainView)
        
        marvelManager.delegate = self
        if let _ = marvelItem {
            RequestStaticParameters.offsetSeries = 0
            self.series.removeAll()
            marvelItemView.setVar(for: marvelItem!)
            marvelManager.fetchSeries(with: marvelItem!.id, limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetSeries)
        }
    }
    
    //MARK: - Constraints
    func setMarvelViewConstraints(for marvelView: UIView) {
        let safeAreaGuide = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        var constraints = [
            marvelView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            marvelView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
        
        constraints = [
            marvelView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaGuide.topAnchor, multiplier: 1.0),
            marvelView.bottomAnchor.constraint(equalToSystemSpacingBelow: safeAreaGuide.bottomAnchor, multiplier: 1.0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Marvel request manager delegate
    func didFinishedWithError(error: String) {
        
    }
    
    func didFinishedFetchSeries(result: [Series]) {
        self.series += result
        RequestStaticParameters.offsetSeries += result.count
        DispatchQueue.main.async {
            self.marvelItemView.seriesTableView.reloadData()
        }
    }
    
    func didFinishedFetchCharacter(result: CharacterResult) {
        
    }

}

extension MarvelItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelItemView.cellRegister, for: indexPath)
        cell.textLabel?.text = "\(String(indexPath.row)):\(series[indexPath.row].title!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return series.count == 0 ? "no series": "Series"
    }
}

extension MarvelItemViewController: UITableViewDataSourcePrefetching {
    //MARK: - UITableViewDataSourcePrefetching
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths[indexPaths.count-1].row == series.count - 1 {
            self.marvelManager.fetchSeries(with: marvelItem!.id, limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetSeries)
        }
    }
}
