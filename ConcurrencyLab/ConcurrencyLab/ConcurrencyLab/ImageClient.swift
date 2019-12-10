//
//  ImageClient.swift
//  ConcurrencyLab
//
//  Created by Maitree Bain on 12/10/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

struct ImageClient {
    
    static func getImage(for urlString: String,
                       completion: @escaping (Result<UIImage?, Error>) -> ()) {
    
    guard let url = URL(string: urlString) else {
        print("no image url found \(urlString)")
        return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
       
        if let error = error {
            print("error: \(error)")
        }
        
        if let data = data {
            let image = UIImage(data: data)
            
            completion(.success(image))
            
        }
       
        
    }
    dataTask.resume()
}
}
