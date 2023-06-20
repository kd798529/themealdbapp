//
//  MealDetailViewController.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/20/23.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    let mealNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Hello"
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mealNameLabel)

        // Do any additional setup after loading the view.
    }
    

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mealNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mealNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mealNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)
        ])
    }
    
}
