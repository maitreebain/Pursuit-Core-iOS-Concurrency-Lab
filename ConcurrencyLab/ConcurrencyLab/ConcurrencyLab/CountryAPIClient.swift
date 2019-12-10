//
//  CountryAPIClient.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/9/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    
    static func fetchData(completion: @escaping (Result<[CountryDataLoad], AppError>) -> ()) {
        let endPointString = "https://restcountries.eu/rest/v2/name/united"
        
        guard let url = URL(string: endPointString) else {
            completion(.failure(.badURL(endPointString)))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        if let error = error {
            completion(.failure(.networkClientError(error)))
        }
        
        guard let urlResponse = response as? HTTPURLResponse else {
            completion(.failure(.noResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        switch urlResponse.statusCode {
        case 200...299:
            break
        default:
            completion(.failure(.badStatusCode(urlResponse.statusCode)))
        }
        
        do {
            let data = try JSONDecoder().decode([CountryDataLoad].self, from: data)
            
            completion(.success(data))
        } catch {
            completion(.failure(.decodingError(error)))
            }
            
        }
        dataTask.resume()
    
}
}
