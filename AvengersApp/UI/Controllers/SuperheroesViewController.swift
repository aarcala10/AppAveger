//
//  SuperHeroesViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 27/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit


class SuperheroesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateAllData()
        
    }
    // MARK: - Private methods
    private var dataProvider = DataProvider()
    
    private var superheroes : [AvengerModel] = []
    private var superheroesList : [Avenger] = []
    
    
    
    // MARK: - Private methods
    
    private func loadSuperheroes (){
        superheroesList = dataProvider.loadAvengerBy(team: .superhero)
//        print ("\(superheroesList)")
        if superheroesList == []{
            setupDataSuperheroes()
            superheroesList = dataProvider.loadAvengerBy(team: .superhero)

        }
    showData()
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
                        let team = 0
                        saveSuperhero(name, hero, bio, power, team, img )
                    }
                    
                    
                } catch {
                    fatalError("Could not read the JSON")
                }
            } else {
                fatalError("Could not build the path url")
            }
        
        //print("\(superheroes)")
    }
    
    
    
    private func saveSuperhero(_ name: String?,_ hero: String,_ bio: String,_ power: Int,_ team: Int,_ img: String) -> Avenger? {
    
        
        guard let superhero = dataProvider.createSuperhero() else  {
            return nil
        }
        superhero.hero = hero
        superhero.name = name
        superhero.bio = bio
        superhero.img = img
        superhero.power = Int16(power)
        superhero.team = Int16(team)
        
        
        
        // Call dataProvider to persist new Avenger
        dataProvider.saveSuperhero(superhero)
        return superhero
    }
    
    private func showData() {
        tableView.reloadData()
    }
    private func updateAllData() {
        loadSuperheroes()
        showData()
    }

}

// MARK: - TableView
extension SuperheroesViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get task count for current task state selected
        return superheroesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvengerViewCell.cellIdentifier,
                                                 for: indexPath) as! AvengerViewCell
        
        if indexPath.row < superheroesList.count {
            // Configure current cell view with Task data
            cell.configure(with: superheroesList[indexPath.row])
        }
        
        return cell
    }
    
    
    
}

// MARK: - Navigation
//extension SuperheroesViewController {
//    // Capture segue navigation for set Self as AddTaskViewController delegate
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get segue destination ViewController, in this case should be
//        // a AddTaskViewController type.
//        // Set AddTaskViewController delegate
//        (segue.destination as? DetailSuperheroViewController)?.delegate = self
//    }
//}

