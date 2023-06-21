//
//  MealDetailViewController.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/20/23.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    var mealID = ""
    
    let mealNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Hello"
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    

    func setupConstraints() {
        view.addSubview(mealNameLabel)
        NSLayoutConstraint.activate([
            mealNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mealNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mealNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30)
        ])
    }
    
}
