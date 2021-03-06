//
//  DetailRecipe.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 06/04/2022.
//

import Foundation
import UIKit
import CoreData

class DetailRecipeViewController: UIViewController {
    
    @IBOutlet weak var nameRecipe: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var ingredientsList: UILabel!
    @IBOutlet weak var cookingTime: UILabel!
    @IBOutlet weak var nbrsOfPeople: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    var recipe: Recipe?
    var favRecipe: RecipeSaved?
    
    override func viewDidLoad() {
       
        cookingTime.text = recipe?.totalTime.description
        ingredientsList.text = recipe?.ingredientLines.joined(separator: "\n")
        nbrsOfPeople.text = recipe?.yield.description
        nameRecipe.text = recipe?.recipeName.description
        if let recipe = recipe
        {
            imageRecipe.image = UIImage(data: recipe.recipeImage)
        }
        alreadyInFavorite()

    }
    
    @objc func onclickAddFavorite(sender:UIButton) {
        guard let recipe = recipe else { return }
        if sender.isSelected == true {
            sender.isSelected = false
            print("not Selected")
            RecipeRepository.shared.remove(nameSaved: recipe.recipeName.description)
           
        }else {
            sender.isSelected = true
            print("Selected")
            RecipeRepository.shared.save(recipe: recipe)
            
            
        }
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        buttonFavorite.addTarget(self, action: #selector(self.onclickAddFavorite), for: .touchUpInside)//Target
        buttonFavorite.setImage(UIImage.init(named: "unfavorite"), for: UIControl.State.normal)//When selected
        buttonFavorite.setImage(UIImage.init(named: "favorite"), for: UIControl.State.highlighted)//When highlighted
        buttonFavorite.setImage(UIImage.init(named: "favorite"), for: UIControl.State.selected)//When selected

    }
    
    @IBAction func getDirections(_ sender: Any) {
        let url = NSURL(string: recipe!.urlDescription)
        UIApplication.shared.open(url! as URL)
    }
    
    func alreadyInFavorite() {
        let fav = RecipeRepository.shared.checkIfRecipeIsAlreadySaved(name: (recipe?.recipeName.description)!)
        if fav == true {
            buttonFavorite.isSelected = true
        }
        
    }
    
}
