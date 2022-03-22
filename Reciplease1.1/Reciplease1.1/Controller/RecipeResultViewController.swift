//
//  ViewController.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 15/03/2022.
//

import UIKit

class RecipeResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension RecipeResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
           return UITableViewCell()
        }

        let recipe = RecipeService.shared.recipes[indexPath.row]
        
        cell.configure(image: recipe.recipeImage, name: recipe.recipeName, ingredients: recipe.ingredientLines, time: recipe.totalTime, numbers: recipe.yield)

        return cell
    }
}



