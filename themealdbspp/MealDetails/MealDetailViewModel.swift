//
//  MealDetailViewModel.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/20/23.
//

import Foundation
import Combine

class MealDetailViewModel {
    
    var mealRecipeID: String
    let service = NetworkService.shared
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var mealsRecipeArray: [String : String?]?
    
    
    
    init(mealRecipeID: String) {
        self.mealRecipeID = mealRecipeID
    }
    
    func getRecipes(mealID: String) {
        let request = GetMealByIDRequest(mealId: mealRecipeID)
        
        service.getMealById(request: request)
            .sink (receiveCompletion: { response in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] meals in
                guard let self = self else {return}
                // trimmed array removes all empty values in the meal array
                let trimmedArray = meals.filter({$0.value != Optional("") && $0.value != Optional(" ")})
                print(trimmedArray)
                print(trimmedArray.count)
                self.mealsRecipeArray = trimmedArray
            }).store(in: &cancellables)
        
        
        
        
    }
    
    func sortDictionaryWithKeys(_ dict: [String: String?]) -> [String: String] {
        let sorted = dict.sorted(by: { $0.key < $1.key })
        var newDict: [String: String] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value
        }
        return newDict
    }
    
    func createArrayFromDictKeys(dict: [String: String?], word: String) -> [String] {
        
        
        var ansArray: [String] = []
        
        let sortedKeys = sortDictionaryWithKeys(dict)

        
        for item in sortedKeys {
            if item.key.contains(word) {
                ansArray.append(item.value)
            }
        }
        
        
        return ansArray
    }
    
    func mergeTwoArraysToDictionary(_ array1: [String], _ array2: [String]) -> [String: String] {
        
        let combinedDictionary = Dictionary(zip(array1, array2),uniquingKeysWith: { (first, _) in first })
        
        return combinedDictionary
    }
    
    
}
