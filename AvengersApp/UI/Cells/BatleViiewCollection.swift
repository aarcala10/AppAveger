//
//  BatleViiewCollection.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 04/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class BatleViiewCollection: UITableViewCell {
    @IBOutlet weak var textCell: UITextView!
    
    @IBOutlet weak var vieCell: UIView!
    
    
    private var batle: Batle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    
    }
    func configure(with batle: Batle){
        self.batle = batle
        
    }
    
    
    private func configureCellView() {
        // Add cell view corner radius
        vieCell.layer.cornerRadius = 12.0
        configureViewShadow()
    }
    private func configureViewShadow() {
        vieCell.layer.shadowColor = UIColor.black.cgColor
        vieCell.layer.shadowOffset = CGSize.zero
        vieCell.layer.shadowRadius = 4.0
        vieCell.layer.shadowOpacity = 0.8
        
    }
    
    
}
