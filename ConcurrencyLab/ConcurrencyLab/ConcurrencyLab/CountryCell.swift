//
//  CountryCell.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/9/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class CountryCell {
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    
    
    func configureCell(for country: CountryDataLoad) {
        
        countryName.text = country.name
        countryCapital.text = country.capital
        countryPopulation.text = country.population.description
    }
}
