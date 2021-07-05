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
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 0
        
        return stack
    }()
    
    private let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.alignment = .center
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
        label.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "name"
        
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
        image.image = UIImage(named: "cat")
    
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
        contentView.addSubview(mainStack)
        setMainStackConstraints()
        
        mainStack.addArrangedSubview(nameView)
        
        nameView.addSubview(nameStack)
        setNameStackConstraints()
        nameStack.addArrangedSubview(nameLabel)
        
        mainStack.addArrangedSubview(imageMarvelView)
        imageMarvelView.addSubview(imageMarvel)
        setImageConstraints()
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
    
    func setNameStackConstraints() {
        let constraints = [
            nameStack.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
            nameStack.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            nameStack.topAnchor.constraint(equalTo: nameView.topAnchor),
            nameStack.bottomAnchor.constraint(equalTo: nameView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints )
    }
   
    func setImageConstraints() {
        let constraints = [
            imageMarvel.trailingAnchor.constraint(equalTo: imageMarvelView.trailingAnchor),
            imageMarvel.leadingAnchor.constraint(equalTo: imageMarvelView.leadingAnchor),
            imageMarvel.topAnchor.constraint(equalTo: imageMarvelView.topAnchor),
            imageMarvel.bottomAnchor.constraint(equalTo: imageMarvelView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints )
    }
    
    //MARK: - set variables
    func setVar() {
       // nameLabel.text = "name"
        //imageView?.image = UIImage(named: "cat")
    }
    
    


    

}
