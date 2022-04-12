//
//  FavoriteRecipeViewController.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 22/03/2022.
//

import Foundation
import UIKit
import CoreData

class FavoriteRecipeViewController: UIViewController {
    
   @IBOutlet weak var favoriteTableView: UITableView!
    
    var recipes: [Recipe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
}

extension FavoriteRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
           return UITableViewCell()
        }

        let recipe = self.recipes?[indexPath.row]
        
        
        cell.configure(
            image: recipe!.recipeImageURL,
            name: recipe!.recipeName,
            ingredients: recipe!.ingredientLines.joined(separator: "\n"),
            time: recipe!.totalTime,
            numbers: recipe!.yield,
            url: recipe!.urlDescription)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailRecipe") as? DetailRecipeViewController {
            let recipe = self.recipes?[indexPath.row]
            vc.recipe = recipe
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



