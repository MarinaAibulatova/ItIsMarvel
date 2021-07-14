//
//  ViewController.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 05.07.2021.
//

import UIKit

class MarvelTableViewController: UIViewController, MarvelCharactersManagerDelegate {

    //MARK: - ui
    private var marvelTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.register(MarvelTableCell.self, forCellReuseIdentifier: MarvelTableCell.registerCellName)
        
        return table
    }()
    
    var upSortButton: UIBarButtonItem!
    var downSortButton: UIBarButtonItem!
    var segmentControll: UISegmentedControl!
    var shownIndexes: [IndexPath] = []
    
    //MARK: - variables
    let marvelManager = MarvelCharactersManager()
    var marvelList: [CharacterResult] = []
    let loadingVC = LoadingScreenViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let loadingVC = LoadingScreenViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        
        //present(loadingVC, animated: true, completion: nil)
        
        self.navigationController?.present(loadingVC, animated: true, completion: nil)
        
        //MARK: - UI components
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Marvel"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: - segment controll
        let sortItems = ["name", "modified"]
        segmentControll = UISegmentedControl(items: sortItems)
        segmentControll.selectedSegmentIndex = 0
        segmentControll.addTarget(self, action: #selector(sortValueChanched), for: .valueChanged)
        navigationItem.titleView = segmentControll
        
        //MARK: - BarButton
        upSortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.circle"), style: .plain, target: self, action: #selector(upTapped))
        downSortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down.circle"), style: .plain, target: self, action: #selector(downTapped))
        
        upSortButton.isEnabled = false
        navigationItem.rightBarButtonItems = [downSortButton, upSortButton]
       
        self.view.addSubview(marvelTableView)
        setMarvelTableViewConstraints()
        
        //MARK: - delegates
        marvelTableView.delegate = self
        marvelTableView.dataSource = self
        marvelTableView.prefetchDataSource = self
        
        //MARK: - Marvel request
        marvelManager.delegate = self
        marvelManager.fetchCharacters(limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetCharacters)
        
    }

    //MARK: - Constraints
    func setMarvelTableViewConstraints() {
        let margins = view.layoutMarginsGuide
        var constraints = [
            marvelTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            marvelTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
        
        let guide = view.safeAreaLayoutGuide
        constraints = [
            marvelTableView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            marvelTableView.bottomAnchor.constraint(equalToSystemSpacingBelow: guide.bottomAnchor, multiplier: 1.0)]
        NSLayoutConstraint.activate(constraints)
    }

    //MARK: - Buttons actions
    @objc func upTapped() {
        fetchCharactersWithParameters()
        upSortButton.isEnabled = false
        downSortButton.isEnabled = true
    }
    
    @objc func downTapped() {
        fetchCharactersWithParameters()
        downSortButton.isEnabled = false
        upSortButton.isEnabled = true
    }
    
    @objc func sortValueChanched() {
        fetchCharactersWithParameters()
    }
    
    func fetchCharactersWithParameters() {
        self.marvelList.removeAll()
        DispatchQueue.main.async {
            self.marvelTableView.reloadData()
        }
        
        RequestStaticParameters.offsetCharacters = 0
        
        let sortValue = getSortValue()
        
        self.marvelManager.fetchCharacters(with: ["orderBy": sortValue], limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetCharacters)
    }
    
    func getSortValue() -> String {
        var sortValue = ""
        if segmentControll.selectedSegmentIndex == 0 {
            sortValue = downSortButton.isEnabled ? "-name" : "name"
        }else {
            sortValue = downSortButton.isEnabled ? "-modified" : "modified"
        }
        RequestStaticParameters.sortValue = sortValue
        return sortValue
    }
    
    //MARK: - MarvelRequestManagerDelegate
    func didFinishedWithError(error: String) {
        print(error)
    }
    
    func didFinishedFetchCharacters(result: [CharacterResult]) {
        self.marvelList += result
        RequestStaticParameters.offsetCharacters += result.count
        
        DispatchQueue.main.async {
            self.loadingVC.dismiss(animated: true, completion: nil)
            self.marvelTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MarvelItemViewController()
        controller.marvelItem = marvelList[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

}

extension MarvelTableViewController: UITableViewDataSourcePrefetching {
    
    //MARK: - UITableViewDataSourcePrefetching
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths[indexPaths.count-1].row == marvelList.count - 1 {
            self.marvelManager.fetchCharacters(with: ["orderBy": RequestStaticParameters.sortValue], limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetCharacters)
        }
    }
}

