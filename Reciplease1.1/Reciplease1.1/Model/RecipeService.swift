//
//  RecipeService.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 22/03/2022.
//

import Foundation
import UIKit

class RecipeService {
    
    static var shared = RecipeService()
    
    private init() {}


    private var recipeSession = URLSession(configuration: .default)

    init(recipeSession: URLSession) {
        self.recipeSession = recipeSession
    }

    private var task: URLSessionDataTask?

    func getRecipe(ingredients: [String], callback: @escaping (Bool, [Recipe]?) ->Void) {

        let onOneLine = ingredients.joined(separator: ";")
        
        let urlString = "https://api.edamam.com/api/recipes/v2?type=public&q=\(onOneLine)&app_id=b5153b3d&app_key=a20c31a57865e7456e53a5ee7770c94a"


        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            , let recipeUrl = URL(string: urlStringEncoded)
        else
        {
            callback(false, nil)
            return
        }

        task?.cancel()
        
        task = recipeSession.dataTask(with: recipeUrl) { (data, response, error) in
            guard let data = data
                    , error == nil
                    , let response = response as? HTTPURLResponse
                    , response.statusCode == 200
                    , let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data)
                    
            else {
                //print(String(data: data!, encoding: .utf8))
                callback(false, nil)
                return
            }
            
            var recipes: [Recipe] = []
            recipeResponse.hits.forEach { hit in
                let recipe = Recipe(
                    recipeName: hit.recipe.label,
                    recipeImageURL: hit.recipe.image,
                    yield: hit.recipe.yield,
                    ingredientLines: hit.recipe.ingredientLines,
                    totalTime: hit.recipe.totalTime,
                    urlDescription: hit.recipe.url)
        
                recipes.append(recipe)
            }
            callback(true, recipes)
        }
        task?.resume()
    }
}
