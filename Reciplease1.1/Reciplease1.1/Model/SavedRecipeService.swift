import CoreData
import UIKit

final class SavedRecipeService
{
    
    static var shared = SavedRecipeService()
    
    private init()
    {
        
    }
    
    func save(recipe: Recipe) -> Void
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "RecipeSaved", in: context)!

        let savedRecipe = NSManagedObject(entity: entity, insertInto: context)

        savedRecipe.setValue(recipe.recipeImageURL, forKey: "imageSaved")
        savedRecipe.setValue(recipe.ingredientLines.joined(separator: ";"), forKey: "ingredientsSaved")
        savedRecipe.setValue(recipe.recipeName, forKey: "nameSaved")
        savedRecipe.setValue(recipe.yield, forKey: "nbrsOfPeopleSaved")
        savedRecipe.setValue(recipe.totalTime, forKey: "timeSaved")
        savedRecipe.setValue(recipe.urlDescription, forKey: "descriptionUrlSaved")

        do {
            try context.save()
        }
        catch let error as NSError {
            print("Il y a une erreur lors de la sauvegarde: \(error)")
        }
    }

    func retrieve() -> [Recipe]
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return [] }

        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSManagedObject>(entityName: "RecipeSaved")
        
        var recipes: [Recipe] = []
        do {
            let objects: [NSManagedObject] = try context.fetch(request)
            let savedRecipes: [RecipeSaved] = objects as! [RecipeSaved]
            savedRecipes.forEach { savedRecipe in
                //Check si t'as toutes les propriétés
                if let name = savedRecipe.value(forKey: "nameSaved")
                    , let image = savedRecipe.value(forKey: "imageSaved")
                    , let time = savedRecipe.value(forKey: "timeSaved")
                    , let yield = savedRecipe.value(forKey: "nbrsOfPeople")
                    , let ingredients = savedRecipe.value(forKey: "ingredientsSaved")
                    , let url = savedRecipe.value(forKey: "descriptionUrlSaved")
                {
                    recipes.append(Recipe(
                        recipeName: name as! String,
                        recipeImageURL: image as! String,
                        yield: yield as! Double,
                        ingredientLines: ingredients as! [String],
                        totalTime: time as! Double,
                        urlDescription: url as! String ))
                }
            }

            return recipes
        }
        catch let error as NSError {
            print("Il y a une erreur lors de la récupération: \(error)")
            return recipes
        }
    }
    
    
    func delete(recipe: Recipe)
    {
        
    }
}

