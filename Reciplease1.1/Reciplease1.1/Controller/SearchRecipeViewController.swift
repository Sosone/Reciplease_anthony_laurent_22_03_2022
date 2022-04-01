//
//  SearchRecipeController.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 18/03/2022.
//

import Foundation
import UIKit

class SearchRecipeViewController: UIViewController,UITextFieldDelegate {
   
    @IBOutlet weak var IngredientToAdd: UITextField!
    @IBOutlet weak var newIngredient: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var searchForRecipes: UIButton!
    private var allCellsText = [String]()
    var recipes: [Recipe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newIngredient.dataSource = self
        newIngredient.delegate = self
        
    }
    
    @IBAction func TapClearButton(_ sender: UIButton) {
        allCellsText.removeAll()
        newIngredient.reloadData()
    }
    
    @IBAction func TapAddButton(sender: UIButton) {
        if let txt = IngredientToAdd.text, !txt.isEmpty {
            allCellsText.append(IngredientToAdd.text!)
            IngredientToAdd.text = ""
        }
        newIngredient.reloadData()
    }
    
    @IBAction func tapSearchButton(_ sender: Any) {
        RecipeService.shared.getRecipe(
            ingredients: allCellsText,
            callback: { success, resultRecipes in
                self.recipes = resultRecipes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toRecipes", sender: nil)
                    print(self.recipes)
                }
            }
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? RecipeResultViewController {
            dataController.recipes = self.recipes
        }
    }
}
    extension SearchRecipeViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCellsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell else {return UITableViewCell()}
        cell.IngredientName.text = allCellsText[indexPath.row]
        return cell
        }
        
    }

