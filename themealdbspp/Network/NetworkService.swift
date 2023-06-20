//
//  NetworkService.swift
//  themealdbspp
//
//  Created by Kwaku Dapaah on 6/19/23.
//

import Foundation
import Combine


struct NetworkService {
    static let shared  = NetworkService()
    
    func getAllMeals(request: GetAllMealsRequest) -> AnyPublisher<[Meal], Error> {
        Deferred {
            Future { promise in
                getMealsData { success, data in
                    if success {
                        if let mealDict = data {
                            guard let mealArray = mealDict["meals"] else {return}

                            promise(.success(mealArray))
                        }
                    } else {
                        promise(.failure(MealsDataError.failureRetrievingMeals))
                    }
                }
            }
        }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getMealsData(_ completion: @escaping (_ success: Bool, _ data: [String: [Meal]]?) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            var result: [String: [Meal]]?
            
            do {
                result = try JSONDecoder().decode([String: [Meal]].self, from: data)
            } catch {
                print("Failed to Decode with error: \(error)")
                completion(false, nil)
            }
            
            guard let final = result else {
                return
            }
                        
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            completion(true, final)
                    
        }
        task.resume()
        
    }
    
    enum MealsDataError: Error {
        case invalidURL
        case invalidResponse
        case failureRetrievingMeals
    }
}
