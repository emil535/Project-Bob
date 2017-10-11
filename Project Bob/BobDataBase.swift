//
//  BobDataBase.swift
//  Project Bob
//
//  Created by Emil Safier on 8/31/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import Foundation
import CoreData


class BobDatabase {
    //   this contains all of CoreData code copied from AppDelegate.swift
    
    private init() {}   //  blocks everyone from making changes to this class
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    // NOTE:  change from 'lazy' to 'static' for this property - facilitates access

    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        // Bob-3  SLIDE 9 - update file name reference
        let container = NSPersistentContainer(name: "BobDataModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
     static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

/*     ref.  https://www.hackingwithswift.com/read/0/18/static-properties-and-methods
    Swift lets you create properties and methods that belong to a type, rather than to instances of a type. This is helpful for organizing your data meaningfully by storing shared data.
    Swift calls these shared properties "static properties", and you create one just by using the static keyword. Once that's done, you access the property by using the full name of the type.
 
 */
