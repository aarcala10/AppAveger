//
//  BatleViewCell.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 02/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class BatleViewCell: UITableViewCell {
    
    static let cellIdentifier: String = String(describing: BatleViewCell.self)
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var batleTitle: UILabel!
    @IBOutlet weak var superheroImg: UIImageView!
    @IBOutlet weak var villainImg: UIImageView!
     
    // MARK: - Private properties
    private var batle: Batle?
    
    // MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    
    }
    
    override func prepareForReuse() {
        batle = nil
        
    }
    // MARK: Configure view methods
    func configure(with batle: Batle) {
        self.batle = batle
        
        update(batleTitle: batle.id)
        update(superhero: batle.superhero?.img)
        update(villain: batle.villain?.img)
        
    }
    
    private func configureCellView() {
        // Add cell view corner radius
        cellView.layer.cornerRadius = 12.0
        configureViewShadow()
    }
    
    // Add a ligth shadow effect to the background cell view
    private func configureViewShadow() {
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize.zero
        cellView.layer.shadowRadius = 4.0
        cellView.layer.shadowOpacity = 0.8
        superheroImg.layer.shadowColor = UIColor.black.cgColor
        superheroImg.layer.shadowOffset = CGSize.zero
        superheroImg.layer.shadowRadius = 4.0
        superheroImg.layer.shadowOpacity = 0.8
        villainImg.layer.shadowColor = UIColor.black.cgColor
        villainImg.layer.shadowOffset = CGSize.zero
        villainImg.layer.shadowRadius = 4.0
        villainImg.layer.shadowOpacity = 0.8
        
    }
    
    // MARK: Private methods
        private func update(batleTitle: Int16) {
            
        }
        private func update (superhero: String?) {
            guard let imagen = superhero else {return}
            superheroImg.image = UIImage.init(named: imagen)
        }
        private func update (villain: String?) {
            guard let imagen = villain else {return}
            villainImg.image = UIImage.init(named: imagen)
        }


    }
