//
//  FigthsViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 28/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class BatlesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateAllData()
            
    }
    // MARK: - Private methods
    private var dataProvider = DataProvider()
    
    private var batles : [BatleModel] = []
    private var batleList : [Batle] = []
    private var batle: Batle?
        
        
    // MARK: - Private methods
    
    private func loadBatles (){
        title = "Batles"
        batleList = dataProvider.loadAllBatles()
        //print ("\(batleList)")
        showData()
    }
        
    private func showData() {
        tableView.reloadData()
    }
    private func updateAllData() {
        loadBatles()
        showData()
    }
    func createBatle(_ batle: Batle?)-> Batle?{
        guard let batle = batle else {return nil}
        
        dataProvider.saveBatle(batle)
        return batle
    
    }
    

}

    // MARK: - TableView
extension BatlesViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
            
        tableView.delegate = self
        tableView.dataSource = self
            
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return batleList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BatleViewCell.cellIdentifier,
                                                for: indexPath) as! BatleViewCell
            
        if indexPath.row < batleList.count {
            cell.configure(with: batleList[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        batle = batleList[indexPath.row]
        performSegue(withIdentifier: "detailBatle", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                    let batle = batleList[indexPath.row]
                    
                    dataProvider.deleteBatle(batle)
                    updateAllData()
                
            
            default:
                break
        }
    }
}

extension BatlesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? DetailBatleViewController)?.delegate = self
        (segue.destination as? DetailBatleViewController)?.batle = batle
        (segue.destination as? AddBatleViewController)?.delegate = self
    }
}

//MARK: Delegate
extension BatlesViewController: DetailBatleDelegate{
    func batleDeleted(_ batle: Batle?) {
        
    }
}

extension BatlesViewController: AddBatleDelegate{
    func saveBatle(_ batle: Batle?) {
        createBatle(batle)
        loadBatles()
        tableView.reloadData()
    }
}
