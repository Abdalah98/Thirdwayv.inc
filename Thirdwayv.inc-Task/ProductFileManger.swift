//
//  ProductFileManger.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 12/06/2022.
//

import Foundation
import UIKit


class ProductFileManager:UIViewController {
    
    static let shared = ProductFileManager()
    var products : [Product]?
    
    struct  CachedProductsData : Codable{
        let products : [Product]
    }
    //
    private func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        print("path : \(String(describing: path.first))")
        return path.first
    }
    
    func cacheProducts(with productsArray : [Product]) {
        do {
            let filePath = documentDirectoryPath()?.appendingPathComponent(ResoneError.persestentFileName.rawValue)
            
            let cachedProductsData = CachedProductsData(products: productsArray)
            let data = try JSONEncoder().encode(cachedProductsData)
            if let productsFilePath = filePath {
                try data.write(to: productsFilePath , options: .atomicWrite)
                
            }
            
        }catch let error {
            print("error caching products\(error.localizedDescription)")
        }
        JSONEncoder().dataEncodingStrategy = .base64
        
    }
    
    func readCachedProducts() -> [Product]? {
        do{
            if let filePath =
                documentDirectoryPath()?.appendingPathComponent(ResoneError.persestentFileName.rawValue){
                
                if let data = try? Data(contentsOf: filePath){
                    JSONDecoder().dataDecodingStrategy = .base64
                    let cachedProductsData = try JSONDecoder().decode(CachedProductsData.self, from: data)
                    self.products = cachedProductsData.products
                }
            }
        }catch let error {
            print("error reading cached products\(error.localizedDescription)")
        }
        return products
    }
    
    
    
}
