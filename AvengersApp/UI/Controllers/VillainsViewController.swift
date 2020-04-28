//
//  VillainsViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 27/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class VillainsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataVillains()
        // Do any additional setup after loading the view.
    }
    
    var villains : [AvengerModel] = []
    
    func setupDataVillains() {
        
        if let pathURL = Bundle.main.url(forResource: "Villains", withExtension: "json") {
                do {
                    let data = try Data.init(contentsOf: pathURL)
                    let decoder = JSONDecoder()
                    villains = try decoder.decode([AvengerModel].self, from: data)
                    
                } catch {
                    fatalError("Could not read the JSON")
                }
            } else {
                fatalError("Could not build the path url")
            }

        //print("\(villains)")
    }

}

