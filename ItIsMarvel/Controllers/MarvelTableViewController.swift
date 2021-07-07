//
//  ViewController.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 05.07.2021.
//

import UIKit

class MarvelTableViewController: UIViewController, MarvelRequestManagerDelegate {

    //MARK: - ui
    private var marvelTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.register(MarvelTableCell.self, forCellReuseIdentifier: MarvelTableCell.registerCellName)
        
        return table
    }()

    func setMarvelTableViewConstraints() {
        let constraints = [
            marvelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            marvelTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            marvelTableView.topAnchor.constraint(equalTo: view.topAnchor),
            marvelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }

    //MARK: - variables
    let marvelRequestManager = MarvelRequestManager()
    var marvelList: [CharacterResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - UI components
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Marvel"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let imageUp = UIImage(systemName: "arrow.up.circle")
        let imageDown = UIImage(systemName: "arrow.down.circle")
        
        //segment controll
        let sortItems = ["name", "id"]
        let segmentControll = UISegmentedControl(items: sortItems)
        segmentControll.selectedSegmentIndex = 0
        navigationItem.titleView = segmentControll
        
        let upButton = UIBarButtonItem(image: imageUp, style: .plain, target: self, action: #selector(upTapped))
        let downButton = UIBarButtonItem(image: imageDown, style: .plain, target: self, action: #selector(upTapped))
        navigationItem.rightBarButtonItems = [upButton, downButton]
       
        self.view.addSubview(marvelTableView)
        setMarvelTableViewConstraints()
        
        //MARK: - delegates
        marvelTableView.delegate = self
        marvelTableView.dataSource = self
        
        //MARK: - Marvel request
        marvelRequestManager.delegate = self
        marvelRequestManager.fetchCharacters()
        
    }


    @objc func upTapped() {
        
    }
    
    func didFinishedWithError(error: String) {
        print(error)
    }
    
    func didFinishedFetchCharacters(result: [CharacterResult]?) {
        if let list = result {
            self.marvelList = list
            DispatchQueue.main.async {
                self.marvelTableView.reloadData()
            }
        }
    }
}

extension MarvelTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UITableViewDaraSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelTableCell.registerCellName, for: indexPath) as! MarvelTableCell
        cell.setVar(for: marvelList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

