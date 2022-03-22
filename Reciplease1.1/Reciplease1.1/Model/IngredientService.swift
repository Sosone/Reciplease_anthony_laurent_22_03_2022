//
//  IngredientService.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 18/03/2022.
//

import Foundation

class IngredientService {
    static let shared = IngredientService()
    private init() {}

    var ingredients = [Ingredient]()

    func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    func remove(at index: Int) {
        ingredients.remove(at: index)
    }
}
