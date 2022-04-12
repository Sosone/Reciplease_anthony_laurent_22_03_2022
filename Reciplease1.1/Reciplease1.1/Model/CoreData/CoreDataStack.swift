//
//  CoreDataStack.swift
//  Reciplease1.1
//
//  Created by Anthony Laurent on 12/04/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Properties
    
    private let persistentContainerName = "DataModel"
    
    // MARK: - Singleton

   static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.viewContext
    }
    
    // MARK: - Private
    
    private init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: persistentContainerName)
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo) for \(storeDescription.description)")
        }
      })
      return container
    }()

}
