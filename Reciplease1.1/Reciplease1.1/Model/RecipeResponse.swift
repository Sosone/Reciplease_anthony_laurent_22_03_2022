//
//  RecipeResponse.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 22/03/2022.
//

import Foundation

struct RecipeResponse: Codable {
    
    let hits: [Recipe]

        struct Recipe: Codable {
            
            let label: String
            let image: String
            let totalTime: Double
            let yield: Double
            let ingredientsLines: String
            let ingredients: [Ingredients]

            struct Ingredients: Codable {
                let food: String
            }
        }
}
