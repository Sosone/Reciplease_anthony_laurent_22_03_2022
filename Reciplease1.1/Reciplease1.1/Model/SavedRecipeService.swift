import CoreData
import UIKit

final class SavedRecipeService
{
    func save(recipe: Recipe) -> Void
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "SavedRecipe", in: context)!
        
        let savedRecipe = NSManagedObject(entity: entity, insertInto: context)
        
        savedRecipe.setValue(recipe.recipeImageURL, forKey: "image")
        savedRecipe.setValue(recipe.ingredientLines.joined(separator: ";"), forKey: "ingredients")
        // TODO : Affecter les autres valeurs
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Il y a une erreur lors de la sauvegarde: \(error)")
        }
    }
    
//    func retrieve() -> [Recipe]
//    {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        else { return [] }
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        let request = NSFetchRequest<NSManagedObject>(entityName: "SavedRecipe")
//
//        do {
//            let objects: [NSManagedObject] = try context.fetch(request)
//            let savedRecipes: [SavedRecipe] = objects as! [SavedRecipe]
//            var recipes: [Recipe] = []
//            savedRecipes.forEach { savedRecipe in
//                //Check si t'as toutes les propriétés
//                if let name = savedRecipe.recipeName
//                    , let image = savedRecipe.image
//                {
//                    recipes.append(Recipe(
//                        recipeName: name,
//                        recipeImageURL: <#T##String#>,
//                        yield: <#T##Double#>,
//                        ingredientLines: <#T##[String]#>,
//                        totalTime: <#T##Double#>
//                        , urlDescription: <#T##String#>
//                    ))
//                }
//            }
//
//            return recipes
//        }
//        catch let error as NSError {
//            print("Il y a une erreur lors de la récupération: \(error)")
//        }
//    }
}
