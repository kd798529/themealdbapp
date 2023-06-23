//
//  MealsViewModel.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/20/23.
//

import Foundation
import Combine

class MealsViewModel {
    let service = NetworkService.shared
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var mealsArray: [Meal]?
    
    
    func getMeals()  {
        let request = GetAllMealsRequest()
        service.getAllMeals(request: request)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            }, receiveValue: { [weak self] meals in
                guard let self = self else {return}
                
                let alphabeticallySortedMeals = meals.sorted {
                    $0.strMeal ?? "" < $1.strMeal ?? ""
                }
                //print(alphabeticallySortedMeals)
                
                self.mealsArray = alphabeticallySortedMeals
            })
            .store(in: &cancellables)
        
    }
    
}
