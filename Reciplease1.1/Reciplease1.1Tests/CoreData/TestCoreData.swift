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

    override func setUp() {
        RecipeRepository.shared.deleteAll()
    }
    
    func testRecipesShouldBeEmpty()
    {
        RecipeRepository.shared.deleteAll()
        let savedRecipes = RecipeRepository.shared.retrieve()
        XCTAssertEqual(savedRecipes.count, 0)
    }
    
    func testSaveRecipe() {
        let image: UIImage = UIImage(named: "recipeDefault")!
        let data: Data = image.jpegData(compressionQuality: 0)!
       
        let recipe: Recipe = Recipe.init(recipeName: "Duck", recipeImage: data, yield: 4, ingredientLines: ["duck,orange"], totalTime: 120, urlDescription: "www.blablabla.fr")
        RecipeRepository.shared.save(recipe: recipe)
        
        let savedRecipes = RecipeRepository.shared.retrieve()
        
        let savedRecipe = savedRecipes.first(where: { $0.recipeName == "Duck" })
        
        XCTAssertNotNil(savedRecipe)
        RecipeRepository.shared.remove(nameSaved: "Duck")
    }
    
    func testShouldDeleteSpecifiedRecipe() {
        let image: UIImage = UIImage(named: "recipeDefault")!
        let data: Data = image.jpegData(compressionQuality: 0)!
       
        let recipe: Recipe = Recipe.init(recipeName: "Duck", recipeImage: data, yield: 4, ingredientLines: ["duck,orange"], totalTime: 120, urlDescription: "www.blablabla.fr")
        RecipeRepository.shared.save(recipe: recipe)
        
        let savedRecipes = RecipeRepository.shared.retrieve()
        
        let savedRecipe = savedRecipes.first(where: { $0.recipeName == "Duck" })
        XCTAssertNotNil(savedRecipe)
        
        RecipeRepository.shared.remove(nameSaved: "Duck")
        
        let savedRecipes2 = RecipeRepository.shared.retrieve()
            
        XCTAssertEqual(savedRecipes2.count, 0)
    }
    
    func testRecipeIsAlreadySaved() {
        let image: UIImage = UIImage(named: "recipeDefault")!
        let data: Data = image.jpegData(compressionQuality: 0)!
       
        let recipe: Recipe = Recipe.init(recipeName: "Duck", recipeImage: data, yield: 4, ingredientLines: ["duck,orange"], totalTime: 120, urlDescription: "www.blablabla.fr")
        RecipeRepository.shared.save(recipe: recipe)
        
        let savedRecipes = RecipeRepository.shared.retrieve()
        let savedRecipe = savedRecipes.first(where: { $0.recipeName == "Duck" })
        XCTAssertNotNil(savedRecipe)
        
        let favRecipe = RecipeRepository.shared.checkIfRecipeIsAlreadySaved(name: "Duck")
        XCTAssertEqual(true, favRecipe)
        RecipeRepository.shared.remove(nameSaved: "Duck")
    }
    
    func testRecipeIsNoFavorite() {
        let favRecipe = RecipeRepository.shared.checkIfRecipeIsAlreadySaved(name: "Duck")
        XCTAssertEqual(false, favRecipe)
    }
    
}
