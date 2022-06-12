//
//  ApiService.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import Foundation
class ApiService {
    
     let productList: URL? = {
        URL(string: URLS.product)
    }()

    
    func fetchAllProducts(from url: URL?,  complete completion: @escaping ((Result<[Product], ResoneError>) -> Void)) {
                guard let url = url else {
                    completion(.failure(.invaldURL))
                    
                    return
                }
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    if let _ = err {
                        completion(.failure(.unableToComplete))
                        return
                    }
        
                    guard response != nil  else {
                        completion(.failure(.invalidResponse))
        
                        return
                    }
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return }
                    do {
                        let objects = try JSONDecoder().decode([Product].self, from: data)
                        // success
                        completion(.success(objects))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }.resume()
    }
}

extension ApiService : ApiServiceProtocol{
    
    func getProductList(completion: @escaping (Result<[Product], ResoneError>) -> Void) {
        fetchAllProducts(from: productList, complete: completion)
    }
  
}
