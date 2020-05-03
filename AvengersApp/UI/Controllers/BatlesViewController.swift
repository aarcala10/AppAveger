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
        
        
    // MARK: - Private methods
    
    private func loadBatles (){
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

}

    // MARK: - TableView
extension BatlesViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
            
        tableView.delegate = self
        tableView.dataSource = self
            
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get task count for current task state selected
        return batleList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BatleViewCell.cellIdentifier,
                                                for: indexPath) as! BatleViewCell
            
    if indexPath.row < batleList.count {
        // Configure current cell view with Task data
        cell.configure(with: batleList[indexPath.row])
        }
        return cell
    }
}
