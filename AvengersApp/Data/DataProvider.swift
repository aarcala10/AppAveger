//
//  DataProvider.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 27/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import Foundation

class DataProvider {
    private var database: Database? = nil
    
    init() {
        database = Database()
    }
    
    deinit {
        database = nil
    }
    
    //MARK: Create:
    func createSuperhero() -> Avenger? {
        return database?.createData() as? Avenger
    }

    
    
    //MARK: Save:
    func saveSuperhero(_ avenger: Avenger) {
        database?.persist(avenger)
    }
    
    
    //MARK: Load all:
    func loadAllSuperheroes() -> [Avenger] {
        guard let data = database?.fecthAllData() as? [Avenger] else {
            return []
        }
        
        return data
    }

    
    
    //MARK: Load by:
    func loadAvengerBy(team: AvengerTeam) -> [Avenger] {
        return database?.fetchDataBy(team: team.rawValue) as? [Avenger] ?? []
    }
    
    
    //MARK: Delete:
    func deleteAvenger(_ avenger: Avenger) {
        database?.delete(data: [avenger])
    }
    
}
