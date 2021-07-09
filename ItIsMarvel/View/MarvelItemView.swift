//
//  MarvelItemView.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 07.07.2021.
//

import UIKit

class MarvelItemView: UIView {
    
    static let cellRegister: String = "marvelItem"
    //MARK: - UI components
    let mainView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    private let imageMarvelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    private let imageMarvel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
    
        return image
    }()
    
    private let descriptionItem: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont(name: "MarkerFelt-Wide", size: 15)
        textView.textColor = UIColor.black
        
        return textView
    }()
    
    let seriesTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: MarvelItemView.cellRegister)
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - create view
    func setView() {
        
        mainView.addSubview(nameLabel)
        mainView.addSubview(imageMarvelView)
        mainView.addSubview(descriptionItem)
        mainView.addSubview(seriesTableView)

        setNameLabelConstraints()
        setImageViewConstraints()
        setDescriptionItemConstraints()
        setSeriesTableViewConstraints()

        imageMarvelView.addSubview(imageMarvel)
        setImageMarvelConstraints()
        
        setVar()
    }
    
    //MARK: - Constraints
    func setNameLabelConstraints() {
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor)]
        
        nameLabel.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setImageViewConstraints() {
        let constraints = [
            imageMarvelView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            imageMarvelView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            imageMarvelView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)]
        
        imageMarvelView.addConstraint(NSLayoutConstraint(item: imageMarvelView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 200))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setDescriptionItemConstraints() {
        let constraints = [
            descriptionItem.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            descriptionItem.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            descriptionItem.topAnchor.constraint(equalTo: imageMarvelView.bottomAnchor)]
        
        descriptionItem.addConstraint(NSLayoutConstraint(item: descriptionItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setSeriesTableViewConstraints() {
        let constraints = [
            seriesTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            seriesTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            seriesTableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            seriesTableView.topAnchor.constraint(equalTo: descriptionItem.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setImageMarvelConstraints() {
        let  constraints = [
            imageMarvel.trailingAnchor.constraint(equalTo: imageMarvelView.trailingAnchor),
            imageMarvel.leadingAnchor.constraint(equalTo: imageMarvelView.leadingAnchor),
            imageMarvel.topAnchor.constraint(equalTo: imageMarvelView.topAnchor),
            imageMarvel.bottomAnchor.constraint(equalTo: imageMarvelView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints )
    }
    
    func setVar() {
        nameLabel.text = "Marvel"
        imageMarvel.image = UIImage(named: "marvel")
        descriptionItem.text = "rkjergjiregeljgvrsdjfgvkngvjkdnrfkgvnjdngvjdnjgrnwfkwkgfkwenfjnwefnjwenjfnwjwnfjwenfjnwejfnwjenfjwnejfnjewqnfjwenfjnwjnfjwejfnjwenfjwjnfjwenfjnwejfnwe"
    }

}

extension MarvelItemView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelItemView.cellRegister, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
