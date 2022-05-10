//
//  TestCoreData.swift
//  Reciplease1.1Tests
//
//  Created by Anthony Laurent on 03/05/2022.
//
import CoreData
import XCTest
@testable import Reciplease1_1

class TestCoreData: XCTestCase {

    func testSaveRecipe() {
        let image: UIImage = UIImage(named: "recipeDefault")!
        let data: Data = image.jpegData(compressionQuality: 0)!
       
        let recipe: Recipe = Recipe.init(recipeName: "Duck", recipeImage: data, yield: 4, ingredientLines: ["duck,orange"], totalTime: 120, urlDescription: "www.blablabla.fr")
        RecipeRepository.shared.save(recipe: recipe)
        XCTAssertEqual(recipe.recipeName, "Duck")
        XCTAssertNotNil(recipe)
    }
    
    func testRetrieveRecipe() {
        let image: UIImage = UIImage(named: "recipeDefault")!
        let data: Data = image.jpegData(compressionQuality: 0)!
        let recipe: Recipe = Recipe.init(recipeName: "Duck", recipeImage: data, yield: 4, ingredientLines: ["duck,orange"], totalTime: 120, urlDescription: "www.blablabla.fr")
        RecipeRepository.shared.save(recipe: recipe)
        var recipes: [Recipe] = []
        recipes = RecipeRepository.shared.retrieve()
        XCTAssertNotNil(recipes.count)
    }
    
    func testCheckIfRecipeIsAlreadySaved() {
        let inFavorite: Bool = RecipeRepository.shared.checkIfRecipeIsAlreadySaved(name: "Duck")
        XCTAssertTrue(inFavorite)
        
    }
    
    func testDelete() {
        
    }
}
