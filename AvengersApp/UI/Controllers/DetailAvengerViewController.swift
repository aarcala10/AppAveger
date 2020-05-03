//
//  DetailAvengerViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 02/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit
protocol DetailAvengerDelegate: AnyObject {
    
}
    
class DetailAvengerViewController: UIViewController {
    
    @IBOutlet weak var avengerImg: UIImageView!
    @IBOutlet weak var powerImg: UIImageView!
    @IBOutlet weak var bioText: UITextView!
    
    @IBOutlet weak var editPowerButton: UIButton!
    
    
    weak var delegate: DetailAvengerDelegate?
    weak var avenger: Avenger?
    
    //MARK: - View LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        setAvengerDetail()
    }
    
    // MARK: - Private methods
    
    private func setAvengerDetail(){
        title = avenger?.hero
        let image = avenger?.img ?? ""
        let power = avenger?.power ?? 10
        var imagePower: String
        
        if power > 1{
            let powerStar = (power/2)
            imagePower = "ic_stars_\(powerStar)"
        }else{
            imagePower = "ic_stars_0"
        }
        
        powerImg.image = UIImage.init(named: imagePower)
        avengerImg.image = UIImage.init(named: image)
        bioText.text = avenger?.bio
    }
    private func configureDetailView() {
        // Add cell view corner radius
        if avenger?.team == 0{
            view.backgroundColor = UIColor.azul
        }else{
            view.backgroundColor = UIColor.rojo
        }
        avengerImg.layer.cornerRadius = 12.0
        configureViewShadow()
    }
    
    // Add a ligth shadow effect to the background cell view
    private func configureViewShadow() {
        avengerImg.layer.borderWidth = 4
        avengerImg.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        avengerImg.layer.shadowColor = UIColor.black.cgColor
        avengerImg.layer.shadowOffset = CGSize.zero
        avengerImg.layer.shadowRadius = 4.0
        avengerImg.layer.shadowOpacity = 0.8
        powerImg.layer.shadowColor = UIColor.black.cgColor
        powerImg.layer.shadowOffset = CGSize.zero
        powerImg.layer.shadowRadius = 4.0
        powerImg.layer.shadowOpacity = 0.8
    }
    
}
extension UIColor {
  static let rojo: UIColor = UIColor(named: "rojo")!
  static let azul: UIColor = UIColor(named: "azul")!
}
