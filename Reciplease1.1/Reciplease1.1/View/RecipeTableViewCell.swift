//
//  RecipeTableViewCell.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 22/03/2022.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var cookingTime: UILabel!
    @IBOutlet weak var nbrsOfPeople: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addShadow()
    }
    
    private func addShadow() {
        recipeImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        recipeImageView.layer.shadowRadius = 2.0
        recipeImageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        recipeImageView.layer.shadowOpacity = 2.0
    }
    
    func configure(image:String, name: String, ingredients: String, time: Double, numbers: Double) {
        recipeImageView.image = UIImage(named: image)
        recipeLabel.text = name
        ingredientsLabel.text = ingredients
        cookingTime.text = "\(time)"
        nbrsOfPeople.text = "\(numbers)"
        
    }
    
}
