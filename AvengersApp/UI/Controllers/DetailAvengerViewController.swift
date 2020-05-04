//
//  DetailAvengerViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 02/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit
protocol DetailAvengerDelegate: AnyObject {
    func avengerPowerEdited(_ avenger: Avenger?)
}
    
class DetailAvengerViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avengerImg: UIImageView!
    @IBOutlet weak var powerImg: UIImageView!
    @IBOutlet weak var bioText: UITextView!
    
    
    @IBOutlet weak var editPowerButton: UIButton!
    
    
    private let dataProvider = DataProvider()
    weak var delegate: DetailAvengerDelegate?
    weak var avenger: Avenger?
    private var batles: [Batle] = []
    private var batle: Batle?
    
    //MARK: - View LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        setAvengerDetail()
        if batles.count == 0{
            tableView.isHidden = true
        }else{
        configureTableView()
        }
        
        
    }
    
    // MARK: - Private methods
    
    private func setAvengerDetail(){
        title = avenger?.hero?.uppercased()
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
        guard let avenger = avenger else {return}
        if avenger.team == 0{
            batles = dataProvider.loadBtaleBy(superhero: avenger)
        }else{
            batles = dataProvider.loadBtaleBy(villain: avenger)
        }
        
        
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
    
    
    
    
    @IBAction func editPower(_ sender: UIButton) {
        performSegue(withIdentifier: "edit", sender: self)
    }
    
}
extension DetailAvengerViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get task count for current task state selected
        return batles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBatalla",
                                                 for: indexPath) as! BatleViiewCollection
        
        if indexPath.row < batles.count{
            
            if batles[indexPath.row].winner == avenger?.hero{
                cell.vieCell.backgroundColor = .green
            }else{
                cell.vieCell.backgroundColor = .red
            }
            
            cell.configure(with: batles[indexPath.row])
            cell.textCell.text = "Batalla \(indexPath.row + 1)"
        
            if avenger?.team == 0{
                cell.backgroundColor = .azul
                tableView.backgroundColor = .azul
            }else {
                cell.backgroundColor = .rojo
                tableView.backgroundColor = .rojo
            }
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        batle = batles[indexPath.row]
        performSegue(withIdentifier: "detailBatle", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

extension UIColor {
  static let rojo: UIColor = UIColor(named: "rojo")!
  static let azul: UIColor = UIColor(named: "azul")!
}


extension DetailAvengerViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? EditPowerViewController)?.delegateEdit = self
        (segue.destination as? EditPowerViewController)?.avenger = avenger
        (segue.destination as? DetailBatleViewController)?.batle = batle
    }
}

//MARK: Delegate
extension DetailAvengerViewController: EditPowerDelegate{
    func powerEdited(_ avenger: Avenger?){
        delegate?.avengerPowerEdited(avenger)
        setAvengerDetail()
    }
}
