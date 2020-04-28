//
//  SuperHeroesViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 27/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class SuperheroesViewController: UIViewController {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSuperheroes()
        
    }
    // MARK: - Private methods
    private var dataProvider = DataProvider()
    
    private var superheroes : [AvengerModel] = []
    private var superheroesList : [Avenger] = []
    
    
    
    // MARK: - Private methods
    
    private func loadSuperheroes (){
        superheroesList = dataProvider.loadAvengerBy(team: .superhero)
        print ("\(superheroesList)")
        if superheroesList == []{
            setupDataSuperheroes()
        }
    }
    
    private func setupDataSuperheroes(){
        
        if let pathURL = Bundle.main.url(forResource: "Superheroes", withExtension: "json") {
                do {
                    
                    let data = try Data.init(contentsOf: pathURL)
                    let decoder = JSONDecoder()
                    superheroes = try decoder.decode([AvengerModel].self, from: data)
                    
                    for avenger in superheroes{
                        let name = avenger.name
                        let bio = avenger.description
                        let hero = avenger.hero
                        let power = avenger.power
                        let img = avenger.img
                        saveSuperhero(name: name, hero: hero, bio: bio, power: power, team: 0, img: img )
                    }
                    
                    
                } catch {
                    fatalError("Could not read the JSON")
                }
            } else {
                fatalError("Could not build the path url")
            }
        
        //print("\(superheroes)")
    }
    
    
    
    private func saveSuperhero(name: String?, hero: String, bio: String, power: Int, team: Int, img: String) -> Avenger? {
    
        
        guard let superhero = dataProvider.createSuperhero() else  {
            return nil
        }
        superhero.hero = hero
        superhero.name = name
        superhero.bio = bio
        superhero.power = Int16(power)
        superhero.team = Int16(team)
        
        
        
        // Call dataProvider to persist new Avenger
        dataProvider.saveSuperhero(superhero)
        return superhero
    }

}

