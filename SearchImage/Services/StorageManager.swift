//
//  StorageManager.swift
//  SearchImage
//
//  Created by Паша Настусевич on 4.09.24.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SearchImage")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func create(_ userMail: String,_ userName: String,_ userPassword: String) {
       let user = User(context: viewContext)
        user.mail = userMail
        user.name = userName
        user.password = userPassword
        saveContext()
    }
    
    func fetchData(completion: (Result<[User], Error>) -> Void) {
        let fetchRequest = User.fetchRequest()
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            completion(.success(users))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(_ user: User, newUserName: String) {
        user.name = newUserName
        saveContext()
    }
    
    func delete(_ user: User) {
        viewContext.delete(user)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


