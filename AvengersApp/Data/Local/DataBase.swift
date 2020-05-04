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
    private let entityAvengerHero = "hero"
    private let entityAvengerName = "name"
    private let entityAvengerTeam = "team"
    private let entityAvengerPower = "power"
    private let entityAvengerBio = "bio"
    
    
    private let entityBatle = "Batle"
    private let entityBatleId = "id"
    private let entityBatleWinner = "winner"
    private let entityBatleLoser = "loser"
    
    
    
    // MARK: - Managed Object Context
    private func context() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
         
        return appDelegate.persistentContainer.viewContext
    }
    
    
    // MARK: - Database methods
    
    //Create
    func createData() -> NSManagedObject? {
        guard let contextMOB = context(),
              let entity = NSEntityDescription.entity(forEntityName: entityAvenger,
                                                      in: contextMOB) else {
            return nil
        }
        
        return Avenger(entity: entity,
                    insertInto: context())
    }
    func createDataBatle() -> NSManagedObject? {
        guard let contextMOB = context(),
              let entity = NSEntityDescription.entity(forEntityName: entityBatle,
                                                      in: contextMOB) else {
            return nil
        }
        
        return Batle(entity: entity,
                    insertInto: context())
    }
    
    
    //Save
    func persist(_ avenger: Avenger) {
        guard let contextMOB = context() else {
            return
        }
        
        try? contextMOB.save()
    }
    func persistBatle(_ batle: Batle) {
        guard let contextMOB = context() else {
            return
        }
        
        try? contextMOB.save()
    }
    
    
    //Load All
    
    func fecthAllData() -> [NSManagedObject]? {
        return try? context()?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityAvenger)) as? [NSManagedObject]
    }
    
    func fecthAllDataBatle() -> [NSManagedObject]? {
        return try? context()?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityBatle)) as? [NSManagedObject]
    }
    
    //Load BY
    
    func fetchDataBy(team: Int) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityAvenger)
        fetchRequest.predicate = NSPredicate(format: "team = \(team)")
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func fetchDataBatleBy(superhero: Avenger) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityBatle)
        fetchRequest.predicate = NSPredicate(format: "superhero = %@",superhero)
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func fetchDataBatleBy(villain: Avenger) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityBatle)
        fetchRequest.predicate = NSPredicate(format: "villain = %@",villain)
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    //Delete
    func delete(data: [NSManagedObject]) {
        let contextMOB = context()
        data.forEach{ contextMOB?.delete($0) }
        
        print("Deleted objects: \(String(describing: contextMOB?.deletedObjects))")
        try? contextMOB?.save()
    }
    
    func deleteBatle(batle: [Batle]) {
        let contextMOB = context()
        batle.forEach{ contextMOB?.delete($0) }
        
        print("Deleted objects: \(String(describing: contextMOB?.deletedObjects))")
        try? contextMOB?.save()
    }
    
}
