//
//  IngredientTableViewCell.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 18/03/2022.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var IngredientName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
        func configure(title: String) {
            
            IngredientName.text = title
           
        }
}
