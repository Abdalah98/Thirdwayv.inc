//
//  APIServiceMock.swift
//  Thirdwayv.inc TaskTests
//
//  Created by Abdallah on 1/29/22.
//

import Foundation
@testable import Thirdwayv_inc_Task
// The mock APIService(APIServiceMock) object doesn’t connect to the real server,
// it’s an object designed only for the test.
// Both APIServiceand APIServiceMock conform to APIServiceProtocol,
// so that we are able to inject different dependency in different situation.
class APIServiceMock: ApiServiceProtocol{


    var fetchProductListIsCalled = false
    var fetchProductsIsCalled = false
    
    var books :Product?
    
    var completeClosure: ((Result<[Product] , ResoneError>) -> ())!

    func getProductList(completion: @escaping (Result<[Product], ResoneError>) -> Void) {
        fetchProductListIsCalled = true
        completeClosure = completion
    }
    
    func fetchAllProducts(from url: URL?, complete: @escaping ((Result<[Product], ResoneError>) -> Void)) {
        fetchProductsIsCalled   = true
    }
    func fetchSuccess() {
        completeClosure(.success([]))
    }

    func fetchFail(error: ResoneError?) {
        completeClosure(.failure(error! ))
    }
}
