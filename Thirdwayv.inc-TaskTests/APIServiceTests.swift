//
//  APIServiceTests.swift
//  Thirdwayv.inc TaskTests
//
//  Created by Abdallah on 1/27/22.
//

import XCTest
@testable import Thirdwayv_inc_Task

class APIServiceTests: XCTestCase {
    var sut: ApiService!
   
    override func setUp() {
        super.setUp()
        sut = ApiService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // testing product
    func test_get_Product_List() {
        // Given
        let promise = XCTestExpectation(description: "Fetch ListProduct")
        var responseError: Error?
        var responseProductList: [Product]?

        // When
        guard let bundle = Bundle.unitTest.path(forResource: "products", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.fetchAllProducts(from: URL(fileURLWithPath: bundle)) { result in
                        switch result {
                        case .success(let response):
                            responseProductList = response
                            promise.fulfill()
                        case .failure(let error):
                            responseError = error
                            promise.fulfill()
                        }
                    }

        wait(for: [promise], timeout: 10)

        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseProductList)
    }
}
