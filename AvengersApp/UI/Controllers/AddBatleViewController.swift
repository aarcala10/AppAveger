//
//  AddBatleViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 03/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit
protocol AddBatleDelegate:AnyObject {
    func saveBatle(_ batle: Batle?)
}
class AddBatleViewController: UIViewController {

    @IBOutlet weak var superheroImg: UIImageView!
    @IBOutlet weak var villainImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBatles()

    }
    
    weak var delegate: AddBatleDelegate?
    private let dataprovider = DataProvider()
    private var batles: [Batle] = []
    private var teamSelect: Int16?
    private var superhero: Avenger?
    private var villain: Avenger?
    private var winner: String?
    
    
    
    private func loadBatles(){
        batles = dataprovider.loadAllBatles()
    }
    private func createWinner(){
        let participants = [superhero,villain]
        let status: [Int16]
        status = [-2,-1,0,1,2]
        let statusSuper = status.randomElement() ?? 0 + (superhero?.power ?? 0)
        let statusVillain = status.randomElement() ?? 0 + (villain?.power ?? 0)
    
        if statusSuper == statusVillain{
            let winnerRandom = participants.randomElement() ?? superhero
            winner = winnerRandom?.hero ?? ""
            
        }else if statusSuper > statusVillain{
            winner = superhero?.hero ?? ""
            }else {
            winner = villain?.hero ?? ""
        }
        
    }
    
    private func createBatle()->Batle? {
        guard let batle = dataprovider.createBatle() else {return nil}
        
        batle.id = Int16(batles.count + 1)
        batle.superhero = superhero
        batle.villain = villain
        batle.winner = winner
        batle.superheroname = superhero?.hero
        batle.villainname = villain?.hero
        
        return batle
    }
    
    
    @IBAction func addSuperhero(_ sender: Any) {
        teamSelect = 0
        performSegue(withIdentifier: "selectAvenger", sender: self)
        
    }
    @IBAction func addVillain(_ sender: Any) {
        teamSelect = 1
        performSegue(withIdentifier: "selectAvenger", sender: self)
        
    }
    @IBAction func createWinner(_ sender: Any){
        createWinner()
        let batle = createBatle()
        delegate?.saveBatle(batle)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func exit(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
}

extension AddBatleViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? SelectAvengerViewController)?.delegate = self
        (segue.destination as? SelectAvengerViewController)?.avengerSelected = teamSelect
        
    }
}

extension AddBatleViewController: SelectAvengerDelegate{
    func superheroSelected(_ avenger: Avenger?) {
        superhero = avenger
        let image = avenger?.img
        superheroImg.image = UIImage.init(named: image ?? "")
        superheroImg.isHidden = false
        
    }
    func villainSelected(_ avenger: Avenger?){
        villain = avenger
        let image = avenger?.img
        villainImg.image = UIImage.init(named: image ?? "")
        villainImg.isHidden = false
    }
}
