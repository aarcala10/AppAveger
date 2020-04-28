//
//  AvengerModel.swift
//  AvengersApp
//
//  Created by Adrian Arcalá Ocón on 28/04/2020.
//  Copyright © 2020 Adrian Arcalá Ocón. All rights reserved.
//

import Foundation

struct AvengerModel: Codable {

    let hero: String
    let name: String?
    let power: Int
    let description: String
    let img: String
}

