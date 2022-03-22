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
    @IBOutlet weak var AddButton: UIButton!
    
    var allCellsText = [String]()
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

