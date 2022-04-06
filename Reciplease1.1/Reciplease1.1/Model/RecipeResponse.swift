//
//  RecipeResponse.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 22/03/2022.
//

import Foundation

struct RecipeResponse: Codable {
    let hits: [Hit]
    
    struct Hit: Codable {
        let recipe: Recipe
    }

    struct Recipe: Codable {
        let label: String
        let image: String
        let url: String
        let yield: Double
        let ingredientLines: [String]
        let totalTime: Double
    }
}
