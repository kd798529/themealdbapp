//
//  MealsTableViewCell.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/19/23.
//

import UIKit

class MealsTableViewCell: UITableViewCell {
    
    static let identifier = "MealsPageTableViewCell"
    
    let cellTitle: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        addSubview(cellTitle)
        addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: topAnchor),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellImage.leftAnchor.constraint(equalTo: leftAnchor),
            
            cellImage.topAnchor.constraint(equalTo: topAnchor),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellImage.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
