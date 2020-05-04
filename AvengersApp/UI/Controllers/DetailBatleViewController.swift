//
//  DetailBatleViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 02/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit
protocol DetailBatleDelegate: AnyObject {
    func batleDeleted(_ batle: Batle?)
}
class DetailBatleViewController: UIViewController {
    
    @IBOutlet weak var winnerText: UITextView!
    @IBOutlet weak var superherImg: UIImageView!
    @IBOutlet weak var villainImg: UIImageView!
    @IBOutlet weak var superheroText: UITextView!
    @IBOutlet weak var villainText: UITextView!
    
    weak var delegate: DetailBatleDelegate?
    weak var batle: Batle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        setDetailBatle()
    }
    
    private func configureDetailView() {
        
        superherImg.layer.cornerRadius = 12.0
        villainImg.layer.cornerRadius = 12.0
        winnerText.layer.cornerRadius = 12.0
        configureViewShadow()
    }
    private func configureViewShadow() {
        superherImg.layer.borderWidth = 4
        superherImg.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        superherImg.layer.shadowColor = UIColor.black.cgColor
        superherImg.layer.shadowOffset = CGSize.zero
        superherImg.layer.shadowRadius = 4.0
        superherImg.layer.shadowOpacity = 0.8
        villainImg.layer.borderWidth = 4
        villainImg.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        villainImg.layer.shadowColor = UIColor.black.cgColor
        villainImg.layer.shadowOffset = CGSize.zero
        villainImg.layer.shadowRadius = 4.0
        villainImg.layer.shadowOpacity = 0.8
        
        winnerText.layer.borderWidth = 4
        winnerText.layer.borderColor = UIColor.black.cgColor
        winnerText.layer.shadowOffset = CGSize.zero
        winnerText.layer.shadowRadius = 4.0
        winnerText.layer.shadowOpacity = 0.8

    }
    
    private func setDetailBatle(){
        superherImg.image = UIImage.init(named: batle?.superhero?.img ?? "")
        superheroText.text = batle?.superhero?.hero
        villainImg.image = UIImage.init(named: batle?.villain?.img ?? "")
        villainText.text = batle?.villain?.hero
        let winner = "Winner: " + (batle?.winner?.uppercased() ?? "")
        winnerText.text = winner
    }
}

