//
//  CountryDataLoad.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/9/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct CountryDataLoad: Decodable {
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
}
