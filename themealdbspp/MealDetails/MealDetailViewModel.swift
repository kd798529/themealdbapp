//
//  MealDetailViewModel.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/20/23.
//

import Foundation
import Combine

class MealDetailViewModel {
    
    let service = NetworkService.shared
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var mealsRecipeArray: [String : String?]?
    
    var mealID: String
    
    init(mealID: String) {
        self.mealID = mealID
    }
    
    func getRecipes(mealID: String) {
        let request = GetMealByIDRequest(mealId: self.mealID)
        
        service.getMealById(request: request)
            .sink { response in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] meals in
                guard let self = self else {return}
                let trimmedArray = meals.filter({$0.value != Optional("") && $0.value != Optional(" ")})
                print(trimmedArray)
                print(trimmedArray.count)
                self.mealsRecipeArray = trimmedArray
            }
        
        
    }
    
}
