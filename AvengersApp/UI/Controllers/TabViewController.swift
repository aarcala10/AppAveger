//
//  TabViewController.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 04/05/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.selectedIndex = UserDefaults.standard.integer(forKey: "tabSelected")

    }
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.set(self.selectedIndex, forKey: "tabSelected")
    }
        
}
