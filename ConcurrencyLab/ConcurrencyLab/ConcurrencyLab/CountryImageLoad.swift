//
//  CountryImageLoad.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/10/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {(data,result,error) in
            
            if let data = data {
                let image = UIImage(data: data)
            }
            
            if let error = error {
                completion(.failure(.decodingError(error)))
            }
            
            
        }
        dataTask.resume()
        
    }
}
