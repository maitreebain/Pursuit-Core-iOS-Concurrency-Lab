//
//  CountriesDetailViewController.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/10/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class CountriesDetailViewController: UIViewController {
    
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var countryCapital: UILabel!
    
    @IBOutlet weak var countryPopulation: UILabel!
    
    var country: CountryDataLoad?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(for: country!)
    }
    
        func loadData(for country: CountryDataLoad) {
           
           countryName.text = country.name
           countryCapital.text = "Capital: \(country.capital)"
           countryPopulation.text = "Population: \(country.population.description)"
    
           ImageClient.getImage(for: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png") { (result) in
               
               switch result {
               case .failure:
                   DispatchQueue.main.async {
                       self.countryImage.image = UIImage(systemName: "xmark")
                   }
               case .success(let image):
                   DispatchQueue.main.async {
                       self.countryImage.image = image
                   }
               }
           }
}
}
