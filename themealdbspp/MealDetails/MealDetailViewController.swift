//
//  MealDetailViewController.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/20/23.
//

import UIKit
import Combine

class MealDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealsDetailPage", for: indexPath) as! IngredientsTableViewCell
        
        cell.ingredient.text = ingredientsArr[indexPath.row]
        cell.measurement.text = measurementArr[indexPath.row]
       
        return cell
    }
    
    
    private var viewModel: MealDetailViewModel!
    private var cancellables: Set<AnyCancellable> = []
    var mealID = ""
    var mealDetailData: [String: String?] = [:]
    var ingredientsList: [String: String] = [:]
    var ingredientsListArray = [[String: String]]()
    var ingredientsArr = [String]()
    var measurementArr = [String]()
    
    init(viewModel: MealDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let mealNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let mealInstructionsLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        
        return textView
    }()
    
    let mealIngredientsView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        setupConstraints()

        // Do any additional setup after loading the view.
        
        viewModel.getRecipes(mealID: mealID)
        setupListeners()
    }
    
    private func setupListeners() {
        viewModel.$mealsRecipeArray.sink { [weak self] mealRecipe in
            guard let self = self else { return }
            self.mealDetailData = mealRecipe ?? [:]
            print(self.mealDetailData)
            mealNameLabel.text = self.mealDetailData["strMeal"] ?? "" as String?
            mealInstructionsLabel.text = self.mealDetailData["strInstructions"] ?? "" as String?
            
            let ingredients = viewModel.createArrayFromDictKeys(dict: self.mealDetailData, word: "strIngredient")
            let ingredientsMeasurement = viewModel.createArrayFromDictKeys(dict: self.mealDetailData, word: "strMeasure")
            
            self.ingredientsArr = ingredients
            self.measurementArr = ingredientsMeasurement
            
            print(self.ingredientsArr)
            print(self.measurementArr)
            
            let ingredientsAndIngredientsMeasure = viewModel.mergeTwoArraysToDictionary(ingredients, ingredientsMeasurement)

            self.ingredientsList = ingredientsAndIngredientsMeasure

            for item in self.ingredientsList {
                self.ingredientsListArray.append(Dictionary(dictionaryLiteral: item))
            }
            self.mealIngredientsView.reloadData()
                        
        }.store(in: &cancellables)
    }
    

    func setupConstraints() {
        view.addSubview(mealNameLabel)
        view.addSubview(mealInstructionsLabel)
        view.addSubview(mealIngredientsView)
        
        mealIngredientsView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "MealsDetailPage")
        mealIngredientsView.delegate = self
        mealIngredientsView.dataSource = self

        NSLayoutConstraint.activate([
            mealNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mealNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mealNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),

            
            mealInstructionsLabel.topAnchor.constraint(equalTo: mealNameLabel.bottomAnchor, constant: 50),
            mealInstructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mealInstructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mealInstructionsLabel.widthAnchor.constraint(equalToConstant: 300),
            mealInstructionsLabel.heightAnchor.constraint(equalToConstant: 300),
            
            mealIngredientsView.topAnchor.constraint(equalTo: mealInstructionsLabel.bottomAnchor, constant: 50),
            mealIngredientsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mealIngredientsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mealIngredientsView.widthAnchor.constraint(equalToConstant: 300),
            mealIngredientsView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
    }
    
}
