//
//  ContainerViewController.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 21.07.2021.
//

import UIKit

class ContainerViewController: UIViewController {
    
    //MARK: - Ui
    private var upSortButton: UIBarButtonItem!
    private var downSortButton: UIBarButtonItem!
    private var segmentControll: UISegmentedControl!
    
    //MARK: - Controllers
    private lazy var marvelTableNameViewController: MarvelTableViewController = {
        var controller = MarvelTableViewController()
        self.addController(asChildViewController: controller)
        
        return controller
    }()
    
    private lazy var marvelTableModifiedViewController: MarvelTableViewController = {
        var controller = MarvelTableViewController()
        self.addController(asChildViewController: controller)
        
        return controller
    }()
    
    override func viewDidLoad() {
        setupView()
    }
    
    //MARK: - Setup view
    private func setupView() {
        setupSegmentContoller()
        setupSortsButton()
        updateView()
    }
    
    //MARK: - Update view
    private func updateView() {
        setSortValue()
        if segmentControll.selectedSegmentIndex == 0 {
            removeController(asChildViewController: marvelTableModifiedViewController)
            addController(asChildViewController: marvelTableNameViewController)
        }else {
            removeController(asChildViewController: marvelTableNameViewController)
            addController(asChildViewController: marvelTableModifiedViewController)
        }
    }
    
    func setSortValue() {
        var sortValue = ""
        if segmentControll.selectedSegmentIndex == 0 {
            sortValue = downSortButton.isEnabled ? "name" : "-name"
        }else {
            sortValue = downSortButton.isEnabled ? "modified" : "-modified"
        }
        RequestStaticParameters.sortValue = sortValue
    }
    
    private func setupSegmentContoller() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Marvel"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: - segment controll
        let sortItems = ["name", "modified"]
        segmentControll = UISegmentedControl(items: sortItems)
        segmentControll.selectedSegmentIndex = 0
        segmentControll.addTarget(self, action: #selector(sortValueChanched), for: .valueChanged)
        navigationItem.titleView = segmentControll
    }
    
    private func setupSortsButton() {
        //MARK: - BarButton
        upSortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.circle"), style: .plain, target: self, action: #selector(upTapped))
        downSortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down.circle"), style: .plain, target: self, action: #selector(downTapped))
        
        upSortButton.isEnabled = false
        navigationItem.rightBarButtonItems = [downSortButton, upSortButton]
    }
    
    //MARK: - Objc Actions
    @objc func sortValueChanched() {
        updateView()
    }
    
    @objc func upTapped() {
        upSortButton.isEnabled = false
        downSortButton.isEnabled = true
        
        setSortValue()
        
        (children.first as? MarvelTableViewController)?.fetchCharactersWithParameters()
    }
    
    @objc func downTapped() {
        downSortButton.isEnabled = false
        upSortButton.isEnabled = true
        
        setSortValue()
        (children.first as? MarvelTableViewController)?.fetchCharactersWithParameters()
    }
    
    //MARK: - Container Views
    private func addController(asChildViewController viewController: MarvelTableViewController) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        setConstraints(for: viewController)
        
        viewController.didMove(toParent: self)
    }
    
    private func removeController(asChildViewController viewController: MarvelTableViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    //MARK: - Constraints
    private func setConstraints(for viewController: MarvelTableViewController) {
        let constraints = [
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    

    

}
