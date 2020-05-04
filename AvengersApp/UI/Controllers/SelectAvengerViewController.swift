//
//  SelectAvengerViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 03/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

protocol SelectAvengerDelegate: AnyObject{
    func superheroSelected(_ avenger: Avenger?)
    func villainSelected(_ avenger: Avenger?)
}


class SelectAvengerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            loadAvenger()
            configureTableView()
            updateAllData()
            
            
        }
    // MARK: - Private methods
    private var dataProvider = DataProvider()
    weak var delegate: SelectAvengerDelegate?
        
    private var avengers : [AvengerModel] = []
    private var avengerList : [Avenger] = []
    private var avenger: Avenger?
    var avengerSelected: Int16?
        
    // MARK: - Private methods
        
    private func loadAvenger (){
        guard let avengerSelected = avengerSelected else{
            return
        }
        if avengerSelected == 0{
            avengerList = dataProvider.loadAvengerBy(team: .superhero)
        }else{
            avengerList = dataProvider.loadAvengerBy(team: .villain)

        }
    showData()
    }
    
    private func showData() {
        tableView.reloadData()
    }
    private func updateAllData() {
        loadAvenger()
        showData()
    }
    private func exit(){
        dismiss(animated: true, completion: nil)
    }

}

    // MARK: - TableView
extension SelectAvengerViewController: UITableViewDelegate, UITableViewDataSource {        func configureTableView() {
            
        tableView.delegate = self
        tableView.dataSource = self
            
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return avengerList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvengerViewCell.cellIdentifier,
                                                    for: indexPath) as! AvengerViewCell
            
        if indexPath.row < avengerList.count {
            cell.configure(with: avengerList[indexPath.row])
        }
        avenger = avengerList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailVC = DetailAvengerViewController()
        avenger = avengerList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        if avengerSelected == 0{
            delegate?.superheroSelected(avenger)
            exit()
        }else {
            delegate?.villainSelected(avenger)
            exit()
        }
        
    }
}

