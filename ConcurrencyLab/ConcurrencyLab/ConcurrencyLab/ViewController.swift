//
//  ViewController.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/6/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [CountryDataLoad]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            CountryAPIClient.getData { (result) in
                
                switch result{
                case .failure(let appError):
                    print("\(appError)")
                case .success(let data):
                    DispatchQueue.main.async {
                        self.countries = data.filter {$0.name.lowercased().contains(self.searchQuery.lowercased())}
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
        }
    
    func loadData() {
        CountryAPIClient.getData { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    self?.countries = data
                }
            }
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let countriesDetailVC = segue.destination as? CountriesDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("no segue found")
        }
        let countrySelected = countries[indexPath.row]
        
        countriesDetailVC.country = countrySelected
        
    }
    
    }


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("cell isn't conformed to country cell")
        }
        
        let selectedCountry = countries[indexPath.row]
        
        cell.configureCell(for: selectedCountry)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            loadData()
            return
        }
            
            searchQuery = searchText
        
    }
}
