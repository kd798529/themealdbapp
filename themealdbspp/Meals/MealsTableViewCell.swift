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
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "questionmark")
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        self.setupViews()   
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with image: URL, and label: String) {
        self.cellTitle.text = label
        self.cellImage.load(url: image)
    }
    
    
    func setupViews() {
        
        self.contentView.addSubview(cellTitle)
        self.contentView.addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            cellTitle.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            cellImage.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            cellImage.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            cellImage.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: 50),
            cellImage.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
