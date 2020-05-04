//
//  EditPowerViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 03/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit
protocol EditPowerDelegate:AnyObject{
    func powerEdited(_ avenger: Avenger?)
}
class EditPowerViewController: UIViewController {

    @IBOutlet weak var avegerTitle: UILabel!
    @IBOutlet weak var starsImg: UIImageView!
    @IBOutlet weak var labelEdit: UILabel!
    @IBOutlet weak var onStarButton: UIButton!
    @IBOutlet weak var twoStarsButton: UIButton!
    @IBOutlet weak var threeStarsButton: UIButton!
    @IBOutlet weak var forStarsButton: UIButton!
    @IBOutlet weak var fiveStarsButton: UIButton!
    
    weak var delegateEdit: EditPowerDelegate?
    weak var avenger: Avenger?
    private var powerSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        setAvengerDetail()
        
    }
    private func setAvengerDetail(){
        let hero = avenger?.hero ?? "null"
        let power = avenger?.power ?? 10
        var imagePower: String
        if power > 1{
            let powerStar = (power/2)
            imagePower = "ic_stars_\(powerStar)"
        }else{
            imagePower = "ic_stars_0"
        }
        avegerTitle.text = hero.uppercased()
        starsImg.image = UIImage.init(named: imagePower)
    }
    
    func setPower(_ power: Int){
        starsImg.image = UIImage.init(named: "ic_stars_\(power)")
        powerSelected = power
    }
    
    private func configureDetailView() {
        // Add cell view corner radius
        
        labelEdit.layer.cornerRadius = 12.0
        configureViewShadow()
    }
    
    // Add a ligth shadow effect to the background cell view
    private func configureViewShadow() {
        labelEdit.layer.borderWidth = 4
        labelEdit.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        labelEdit.layer.shadowColor = UIColor.black.cgColor
        labelEdit.layer.shadowOffset = CGSize.zero
        labelEdit.layer.shadowRadius = 4.0
        labelEdit.layer.shadowOpacity = 0.8
                
    }
    
    @IBAction func setPowerOne(_ sender: Any) {
        setPower(1)
    }
    @IBAction func setPoweTwo(_ sender: Any) {
        setPower(2)
    }
    @IBAction func setPowerThree(_ sender: Any) {
        setPower(3)
    }
    @IBAction func setPowerFor(_ sender: Any) {
        setPower(4)
    }
    @IBAction func setPowerFive(_ sender: Any) {
        setPower(5)
    }
    
    @IBAction func savePower(_ sender: Any) {
        avenger?.power = Int16(powerSelected ?? 5)*2
        delegateEdit?.powerEdited(avenger)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
