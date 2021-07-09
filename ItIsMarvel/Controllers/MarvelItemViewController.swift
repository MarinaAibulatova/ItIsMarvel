//
//  MarvelItemViewController.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 07.07.2021.
//

import UIKit

class MarvelItemViewController: UIViewController {

    var marvelItem: CharacterResult?
    var seriesTable: UITableView!
    
    let testArray: [String] = Array(repeating: "new", count: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let marvelItemView = MarvelItemView()
        marvelItemView.seriesTableView.delegate = self
        marvelItemView.seriesTableView.dataSource = self
        
        self.view.addSubview(marvelItemView.mainView)
        setMarvelViewConstraints(for: marvelItemView.mainView)
        
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

}

extension MarvelItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelItemView.cellRegister, for: indexPath)
        cell.textLabel?.text = testArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
