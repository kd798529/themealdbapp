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
        tableview.allowsSelection = true
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
        tableView.register(MealsTableViewCell.self, forCellReuseIdentifier: "MealsPageTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
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
            //print(self.meals)
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
    

    

}

extension MealsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealsPageTableViewCell", for: indexPath) as? MealsTableViewCell else {
            fatalError("the TableView could not dequeue a Custom cell in view")
        }
        //cell.backgroundColor = .systemMint
        //cell.textLabel?.text = meals[indexPath.row].strMeal
        
        if let label = self.meals[indexPath.row].strMeal, let imageUrlString = self.meals[indexPath.row].strMealThumb  {
            
            let imgUrl = URL(string: imageUrlString)
            if let imgUrl = imgUrl {
                    cell.configureCell(with: imgUrl, and: label)
            }
            print("this is the Mmeal name label: \(label)" )
            //print(img ?? UIImage(systemName: "questionmark"))
            
        }
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMeal = meals[indexPath.row]
        
        let mealDetailVM = MealDetailViewModel(mealRecipeID: selectedMeal.idMeal ?? "")
        
        let vc = MealDetailViewController(viewModel: mealDetailVM)
        if let mealID = selectedMeal.idMeal {
            vc.mealID = mealID
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
