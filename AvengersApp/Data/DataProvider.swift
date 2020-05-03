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
    func createAvenger() -> Avenger? {
        
        return database?.createData() as? Avenger
    }
    func createBatle() -> Batle? {
        return database?.createDataBatle() as? Batle
    }

    
    //MARK: Save:
    func saveAvenger(_ avenger: Avenger) {
        database?.persist(avenger)
    }
    func saveBatle(_ batle: Batle) {
        database?.persistBatle(batle)
    }
    
    //MARK: Load all:
    func loadAllAvengers() -> [Avenger] {
        guard let data = database?.fecthAllData() as? [Avenger] else {
            return []
        }
        
        return data
    }
    func loadAllBatles() -> [Batle] {
        guard let data = database?.fecthAllDataBatle() as? [Batle] else {
            return []
        }
        
        return data
    }
    
    
    //MARK: Load by:
    func loadAvengerBy(team: AvengerTeam) -> [Avenger] {
        return database?.fetchDataBy(team: team.rawValue) as? [Avenger] ?? []
    }
    func loadBtaleBy(id: Int16) -> [Batle] {
        return database?.fetchDataBatleBy(id: id) as? [Batle] ?? []
    }
    
    //MARK: Delete:
    func deleteAvenger(_ avenger: Avenger) {
        database?.delete(data: [avenger])
    }
    
}
