//
//  ViewController.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 15/03/2022.
//

import UIKit
import Alamofire

class RecipeResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [Recipe]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        tableView.rowHeight = 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? RecipeResultViewController {
            dataController.recipes = self.recipes
        }
    }
}

extension RecipeResultViewController: UITableViewDataSource, UITableViewDelegate {
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
    




