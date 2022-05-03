import CoreData
import UIKit

final class RecipeRepository {
    
    static var shared = RecipeRepository()
    
    // MARK: - Properties

    private let coreDataStack: CoreDataStack

    // MARK: - Init

    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Repository

    func recipeIsAlreadyInFavorite() {
        
    }
    
   
    
//    func remove() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        else { return }
//        let persistentContainer: NSPersistentContainer
//        let object = NSManagedObject
//        let context = appDelegate.persistentContainer.viewContext
//
//        try? context.delete(object)
//
//        try? context.save()
        
//        let fetchRequest: NSFetchRequest<RecipeSaved>
//        fetchRequest = RecipeSaved.fetchRequest()
//
//        fetchRequest.predicate =
//        fetchRequest.includesPropertyValues = false
//
//        let context = persistentContainer.viewContext
//
//        let objects = try context.fetch(fetchRequest)
//
//        for object in objects {
//            context.delete(object)
//        }
//        try context.save()
//    }
    
    func save(recipe: Recipe) -> Void {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "RecipeSaved", in: context)!

        let savedRecipe = NSManagedObject(entity: entity, insertInto: context)
        
//        let image = UIImage()
//        
//        savedRecipe.setValue(image.pngData, forKey: "imageSaved")
        savedRecipe.setValue(recipe.recipeImage, forKey: "imageSaved")
        savedRecipe.setValue(recipe.ingredientLines.joined(separator: ";"), forKey: "ingredientsSaved")
        savedRecipe.setValue(recipe.recipeName, forKey: "nameSaved")
        savedRecipe.setValue(recipe.yield, forKey: "nbrsOfPeopleSaved")
        savedRecipe.setValue(recipe.totalTime, forKey: "timeSaved")
        savedRecipe.setValue(recipe.urlDescription, forKey: "descriptionUrlSaved")

        do {
            try context.save()
            print("La recette est sauvegardée")
        }
        catch let error as NSError {
            print("Il y a une erreur lors de la sauvegarde: \(error)")
        }
    }

    func retrieve() -> [Recipe] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return [] }

        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeSaved")

        var recipes: [Recipe] = []
        do {
            let objects: [NSManagedObject] = try context.fetch(request) as! [NSManagedObject]
            objects.forEach { object in
                //Check si t'as toutes les propriétés
                if let name = object.value(forKey: "nameSaved")
                    , let image = object.value(forKey: "imageSaved")
                    , let time = object.value(forKey: "timeSaved")
                    , let yield = object.value(forKey: "nbrsOfPeopleSaved")
                    , let ingredients = object.value(forKey: "ingredientsSaved") as? String
                    , let url = object.value(forKey: "descriptionUrlSaved")
                {
                    recipes.append(Recipe(
                        recipeName: name as! String,
                        recipeImage: image as! Data,
                        yield: yield as! Double,
                        ingredientLines: ingredients.split(separator: ";").map { String($0) },
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
}
