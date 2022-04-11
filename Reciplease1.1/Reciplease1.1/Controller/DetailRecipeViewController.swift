//
//  DetailRecipe.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 06/04/2022.
//

import Foundation
import UIKit

class DetailRecipeViewController: UIViewController {
    
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var ingredientsList: UILabel!
    @IBOutlet weak var cookingTime: UILabel!
    @IBOutlet weak var nbrsOfPeople: UILabel!
    
    var recipe: Recipe?
    
    @IBAction func addFavorite(_ sender: Any) {
    
    }
    @IBAction func getDirections(_ sender: Any) {
        let url = NSURL(string: recipe?.urlDescription ?? "http:www.google.com")
        UIApplication.shared.open(url! as URL)
    }
    override func viewDidLoad() {
        cookingTime.text = recipe?.totalTime.description
        ingredientsList.text = recipe?.ingredientLines.joined(separator: "\n")
        nbrsOfPeople.text = recipe?.yield.description
        
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let url = currentURL?
//        UIApplication.shared.open(url)
//    }
}

