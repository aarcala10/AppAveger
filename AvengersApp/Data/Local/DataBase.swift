//
//  DataBase.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 27/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit
import CoreData


class Database {
    // MARK: - Properties
    private let entityAvenger = "Avenger"
    private let entityAvengerId = "id"
    private let entityAvengerName = "name"
    private let entityAvengerTeam = "team"
    private let entityAvengerPower = "power"
    private let entityAvengerBio = "bio"
    
    
    // MARK: - Managed Object Context
    private func context() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
         
        return appDelegate.persistentContainer.viewContext
    }
    
    
    // MARK: - Database methods
    func createData() -> NSManagedObject? {
        guard let contextMOB = context(),
              let entity = NSEntityDescription.entity(forEntityName: entityAvenger,
                                                      in: contextMOB) else {
            return nil
        }
        
        return Avenger(entity: entity,
                    insertInto: context())
    }
    
    func persist(_ task: Avenger) {
        guard let contextMOB = context() else {
            return
        }
        
        try? contextMOB.save()
    }
    
    func fecthAllData() -> [NSManagedObject]? {
        return try? context()?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityAvenger)) as? [NSManagedObject]
    }
    
    func fetchDataBy(team: Int) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityAvenger)
        fetchRequest.predicate = NSPredicate(format: "team = \(team)")
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    
    func delete(data: [NSManagedObject]) {
        let contextMOB = context()
        data.forEach{ contextMOB?.delete($0) }
        
        print("Deleted objects: \(String(describing: contextMOB?.deletedObjects))")
        try? contextMOB?.save()
    }
    
}
