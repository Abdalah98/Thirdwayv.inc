//
//  ApiServiceProtocol.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import Foundation
protocol ApiServiceProtocol {
    
    func getProductList(completion: @escaping (Result<[Product] , ResoneError>) -> Void)
    func fetchAllProducts(from url: URL?, complete: @escaping ((Result<[Product] , ResoneError>) -> Void))

}
