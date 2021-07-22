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
    
    //MARK: - variables
    let marvelManager = MarvelCharactersManager()
    var marvelList: [CharacterResult] = []
    let loadingVC = LoadingScreenViewController()
    var sortValue: String = "name"
    
    //MARK: - override for view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let loadingVC = LoadingScreenViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        
        //present(loadingVC, animated: true, completion: nil)
        
       //self.navigationController?.present(loadingVC, animated: true, completion: nil)
        
        self.view.addSubview(marvelTableView)
        setMarvelTableViewConstraints()
        
        //MARK: - delegates
        marvelTableView.delegate = self
        marvelTableView.dataSource = self
        marvelTableView.prefetchDataSource = self
        
        //MARK: - Marvel request
        marvelManager.delegate = self
        //marvelManager.fetchCharacters(with: ["orderBy": sortValue], limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetCharacters)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RequestStaticParameters.offsetCharacters = 0
        
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(loadingVC, animated: true, completion: nil)
        marvelManager.fetchCharacters(with: ["orderBy": RequestStaticParameters.sortValue], limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetCharacters)
        
        print(RequestStaticParameters.limit)
    }
    
    convenience init(with sort: String) {
        self.init()
        //self.sortValue = sort
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

   
    func fetchCharactersWithParameters() {
        self.marvelList.removeAll()
        DispatchQueue.main.async {
            self.marvelTableView.reloadData()
        }

        RequestStaticParameters.offsetCharacters = 0
        self.marvelManager.fetchCharacters(with: ["orderBy": RequestStaticParameters.sortValue], limit: RequestStaticParameters.limit, offset: RequestStaticParameters.offsetCharacters)
    }
    
    
    //MARK: - MarvelRequestManagerDelegate
    func didFinishedWithError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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

