//
//  IngredientsTableViewCell.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/22/23.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    static let identifier = "MealsDetailPage"
    
    let ingredient: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let measurement: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        addSubview(ingredient)
        addSubview(measurement)
        
        NSLayoutConstraint.activate([
            ingredient.topAnchor.constraint(equalTo: topAnchor),
            ingredient.bottomAnchor.constraint(equalTo: bottomAnchor),
            ingredient.leftAnchor.constraint(equalTo: leftAnchor),
            
            measurement.topAnchor.constraint(equalTo: topAnchor),
            measurement.bottomAnchor.constraint(equalTo: bottomAnchor),
            measurement.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
