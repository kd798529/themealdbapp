//
//  MealsViewController.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/19/23.
//

import UIKit
import Combine

class MealsViewController: UIViewController {
    
    let viewModel = MealsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private var meals: [Meal] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
        setupConstraints()
        title = "Meal List"
        viewModel.getMeals()
        setupListeners()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func setupListeners() {
        viewModel.$mealsArray.sink { [weak self] meals in
            guard let self = self else {return}
            self.meals = meals ?? []
            print(self.meals)
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
    

    

}

extension MealsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemMint
        cell.textLabel?.text = meals[indexPath.row].strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedMeal = meals[indexPath.row]
        
        let vc = MealDetailViewController()
        if let mealID = selectedMeal.idMeal {
            vc.mealID = mealID
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
}
