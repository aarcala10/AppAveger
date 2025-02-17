//
//  VillainsViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 27/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class VillainsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationController?.navigationBar.topItem?.title = "Villain"
         
            configureTableView()
            updateAllData()
            
        }
        // MARK: - Private methods
        private var dataProvider = DataProvider()
        
        private var villains : [AvengerModel] = []
        private var villainsList : [Avenger] = []
        private var avenger: Avenger?
        
        
        
        // MARK: - Private methods
        
        private func loadVillains (){
            villainsList = dataProvider.loadAvengerBy(team: .villain)
    //        print ("\(superheroesList)")
            if villainsList == []{
                setupDataVillains()
                villainsList = dataProvider.loadAvengerBy(team: .villain)

            }
        showData()
        }
        
        private func setupDataVillains(){
            
            if let pathURL = Bundle.main.url(forResource: "Villains", withExtension: "json") {
                    do {
                        
                        let data = try Data.init(contentsOf: pathURL)
                        let decoder = JSONDecoder()
                        villains = try decoder.decode([AvengerModel].self, from: data)
                        
                        for avenger in villains{
                            let name = avenger.name
                            let bio = avenger.description
                            let hero = avenger.hero
                            let power = avenger.power
                            let img = avenger.img
                            let team = 1
                            saveVillains(name, hero, bio, power, team, img )
                        }
                        
                    } catch {
                        fatalError("Could not read the JSON")
                    }
                } else {
                    fatalError("Could not build the path url")
                }
            
            //print("\(superheroes)")
        }
        
        
        
        private func saveVillains(_ name: String?,_ hero: String,_ bio: String,_ power: Int,_ team: Int,_ img: String) -> Avenger? {
        
            
            guard let villain = dataProvider.createAvenger() else  {
                return nil
            }
            villain.hero = hero
            villain.name = name
            villain.bio = bio
            villain.img = img
            villain.power = Int16(power)
            villain.team = Int16(team)
            
            
            
            // Call dataProvider to persist new Avenger
            dataProvider.saveAvenger(villain)
            return villain
        }
        
        private func showData() {
            tableView.reloadData()
        }
        private func updateAllData() {
            loadVillains()
            showData()
        }
        private func updateAvenger(_ avenger: Avenger?) -> Avenger? {
            guard let villain = avenger else {return nil}
            dataProvider.saveAvenger(villain)
            return villain
    
        }
}

    // MARK: - TableView
    extension VillainsViewController: UITableViewDelegate, UITableViewDataSource {
        func configureTableView() {
            
            tableView.delegate = self
            tableView.dataSource = self
            

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return villainsList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: AvengerViewCell.cellIdentifier,
                                                     for: indexPath) as! AvengerViewCell
            
            if indexPath.row < villainsList.count {
                cell.configure(with: villainsList[indexPath.row])
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //let detailVC = DetailAvengerViewController()
            avenger = villainsList[indexPath.row]
            performSegue(withIdentifier: "villainToDetail", sender: Any?.self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
}
// MARK: - Navigation
extension VillainsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? DetailAvengerViewController)?.delegate = self
        (segue.destination as? DetailAvengerViewController)?.avenger = avenger
    }
}

//MARK: Delegate
extension VillainsViewController: DetailAvengerDelegate{
    func avengerPowerEdited(_ avenger:Avenger?) {
        updateAvenger(avenger)
        tableView.reloadData()
    }
}


  



