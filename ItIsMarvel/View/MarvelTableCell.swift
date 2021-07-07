//
//  MarvelTableCell.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 05.07.2021.
//

import UIKit

class MarvelTableCell: UITableViewCell {
    
    //MARK: - UI components
    static let registerCellName: String = "MarvelCell"
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        
        return stack
    }()
    
    private let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        
        return stack
    }()
    
    private let nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.contentMode = .scaleAspectFit
        
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - set cell
    func setCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageMarvelView)
        
        //label
        var constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor)]
        
        nameLabel.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30))
        
        NSLayoutConstraint.activate(constraints)
        
        //image
        constraints = [
            imageMarvelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageMarvelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageMarvelView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            imageMarvelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints )
        
        imageMarvelView.addSubview(imageMarvel)
        
        //image
        constraints = [
            imageMarvel.trailingAnchor.constraint(equalTo: imageMarvelView.trailingAnchor),
            imageMarvel.leadingAnchor.constraint(equalTo: imageMarvelView.leadingAnchor),
            imageMarvel.topAnchor.constraint(equalTo: imageMarvelView.topAnchor),
            imageMarvel.bottomAnchor.constraint(equalTo: imageMarvelView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints )
        
//        contentView.addSubview(mainStack)
//        setMainStackConstraints()
//
//        mainStack.addArrangedSubview(nameView)
//        mainStack.addArrangedSubview(imageMarvelView)
//
//        nameView.addSubview(nameLabel)
//        setNameConstraints()
//
//        mainStack.addArrangedSubview(imageMarvelView)
//        imageMarvelView.addSubview(imageMarvel)
//        setImageConstraints()
    }
    
    //MARK: - Constraints
    func setMainStackConstraints() {
        let constraints = [
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setNameConstraints() {
        let constraints = [
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints )
    }
   
    func setImageConstraints() {
        let constraints = [
            imageMarvel.trailingAnchor.constraint(equalTo: imageMarvelView.trailingAnchor, constant: -50),
            imageMarvel.leadingAnchor.constraint(equalTo: imageMarvelView.leadingAnchor, constant: 50),
            imageMarvel.topAnchor.constraint(equalTo: imageMarvelView.topAnchor, constant: 10),
            imageMarvel.bottomAnchor.constraint(equalTo: imageMarvelView.bottomAnchor, constant: -50)]
        
        NSLayoutConstraint.activate(constraints )
    }
    
    //MARK: - set variables
    func setVar(for item: CharacterResult) {
        nameLabel.text = item.name
    
        //image
        if let thumbnail = item.thumbnail {
            let urlString = thumbnail.path! + "." + thumbnail.extensionString!
            if let url = URL(string: urlString) {
                let data = try? Data(contentsOf: url)
                if let _ = data {
                    imageMarvel.image = UIImage(data: data!)
                }
            }
        }
        //imageView?.image = UIImage(named: "cat")
    }
    
    


    

}
