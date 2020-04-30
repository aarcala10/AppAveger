//
//  AvengerViewCell.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 29/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit


class AvengerViewCell: UITableViewCell {
    
    static let cellIdentifier: String = String(describing: AvengerViewCell.self)
    
    @IBOutlet weak var cellView : UIView!
    @IBOutlet weak var heroText: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    // MARK: - Private properties
    private var avenger: Avenger?
    
    // MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    
    }
    
    override func prepareForReuse() {
        avenger = nil
        update(hero: nil)
        update(img: nil)

    }
    // MARK: Configure view methods
    func configure(with avenger: Avenger) {
        self.avenger = avenger
        
        update(hero: avenger.hero)
        update(img: avenger.img)
    }
    
    private func configureCellView() {
        // Add cell view corner radius
        cellView.layer.cornerRadius = 4.0
        configureViewShadow()
    }
    
    // Add a ligth shadow effect to the background cell view
    private func configureViewShadow() {
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOffset = CGSize.zero
        cellView.layer.shadowRadius = 4.0
        cellView.layer.shadowOpacity = 0.2
        imgView.layer.shadowColor = UIColor.gray.cgColor
        imgView.layer.shadowOffset = CGSize.zero
        imgView.layer.shadowRadius = 4.0
        imgView.layer.shadowOpacity = 0.2
        
    }
    
    
    // MARK: Private methods
    private func update(hero: String?) {
        heroText.text = hero
    }
    private func update (img: String?) {
        guard let imagen = img else {return}
        imgView.image = UIImage.init(named: imagen)
    }

}
