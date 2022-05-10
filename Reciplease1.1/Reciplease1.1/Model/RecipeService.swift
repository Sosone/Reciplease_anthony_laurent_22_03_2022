//
//  RecipeService.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 22/03/2022.
//

import Foundation
import UIKit
import Alamofire

class RecipeService {
    
    static var shared = RecipeService()
    
    private var session: Alamofire.Session
    private var imageLoader: (URL) -> Data?
    
    private init() {
        // HTTP
        self.session = Alamofire.Session(configuration: .default)
        self.imageLoader = { url in
            return try? Data(contentsOf: url)
        }
    }

    init(session: Alamofire.Session, imageLoader: @escaping (URL) -> Data?) {
        // Injecté
        self.session = session
        self.imageLoader = imageLoader
    }

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
        
        self.session.request(recipeUrl).responseDecodable(of: RecipeResponse.self) { response in
            switch response.result {
                case .success(let recipeResponse):
                    var recipes: [Recipe] = []
                    recipeResponse.hits.forEach { hit in
                        if let url = URL(string: hit.recipe.image)
                            , let data = self.imageLoader(url)
                        {
                            let recipe = Recipe(
                                recipeName: hit.recipe.label,
                                recipeImage: data,
                                yield: hit.recipe.yield,
                                ingredientLines: hit.recipe.ingredientLines,
                                totalTime: hit.recipe.totalTime,
                                urlDescription: hit.recipe.url)
                            
                            recipes.append(recipe)
                        }
                    }
                    callback(true, recipes)
                case .failure(let error):
                    callback(false, nil)
            }
        }
    }
}
