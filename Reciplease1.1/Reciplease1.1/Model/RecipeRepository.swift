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

   
    
    func save(recipe: Recipe) -> Void {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "RecipeSaved", in: context)!

        let savedRecipe = NSManagedObject(entity: entity, insertInto: context)
        

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
    
    func remove(recipe: RecipeSaved) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RecipeSaved", in: context)!
        let savedRecipe = NSManagedObject(entity: entity, insertInto: context)
        let fetchRequest: NSFetchRequest<RecipeSaved> = RecipeSaved.fetchRequest()
        let namePredicate = NSPredicate(format: "nameSaved == %@", recipe.nameSaved as! CVarArg)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate])
        do {
            let objects: [NSManagedObject] = try context.fetch(fetchRequest) as [NSManagedObject]
            objects.forEach { object in


            }
            try context.delete(savedRecipe)
            print("La recette est supprimée")
            try context.save()

        }
        catch let error as NSError {
            print("Il y a une erreur lors de la suppression: \(error)")
        }
    }
    
   
                
        func checkIfRecipeIsAlreadySaved(name: String) -> Bool {
            let request: NSFetchRequest<RecipeSaved> = RecipeSaved.fetchRequest()
            request.predicate = NSPredicate(format: "nameSaved == %@", name)
            guard let recipes = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return false}
            if recipes.isEmpty { return false }
            return true
        }
    

}
