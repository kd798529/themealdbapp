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
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
