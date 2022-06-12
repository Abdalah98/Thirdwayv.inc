//
//  APIServiceMock.swift
//  Thirdwayv.inc TaskTests
//
//  Created by Abdallah on 1/29/22.
//


import XCTest
@testable import Thirdwayv_inc_Task

class ProductListViewModelTests: XCTestCase {
    var sut: ProductListViewModel!
   
    var apiServiceMock: APIServiceMock!

    override func setUp() {
        super.setUp()
        // creat an instance of the mock in BooksViewModelTests
        apiServiceMock = APIServiceMock()
        // inject apiServiceMock to TopFreeBookViewModel
        sut = ProductListViewModel(apiService: apiServiceMock)
      // test testCreateCellViewModel

    }
    
    override func tearDown() {
       sut = nil

       apiServiceMock = nil
        super.tearDown()
    }
    
   
    func test_populated_state_when_fetching() {
        
        //Given
        var state: State = .empty
        let expect = XCTestExpectation(description: "Loading state updated to populated")
        sut.updateLoadingStatus = { [weak sut] in
            state = sut!.state
            expect.fulfill()
        }
        
        //when fetching
        sut.initFetchProductData()
        
        // Assert
        XCTAssertEqual(state, State.loading)

        // When finished fetching
        apiServiceMock!.fetchSuccess()
        XCTAssertEqual(state, State.populated)

        wait(for: [expect], timeout: 1.0)
    }
    
    func test_error_state_when_fetching() {
        
        //Given
        var state: State? = .empty
        let promise = XCTestExpectation(description: "Loading state updated to error")
        sut.updateLoadingStatus = { [weak sut] in
            state = sut?.state
            promise.fulfill()
        }
        // Given a failed fetch with a certain failure
        let error = ResoneError.invalidResponse
        
        //when fetching
        sut.initFetchProductData()
        
        wait(for: [promise], timeout: 1.0)
        
        // Assert
        XCTAssertEqual(state, State.loading)
        
        // When finished fetching
        apiServiceMock?.fetchFail(error: error)
        XCTAssertEqual(state, State.error)
    }
    // A test method’s name always begins with test, followed by a description of what it tests.

    // It’s good practice to format the test into given, when and then sections
    // Given: Here, you set up any values needed.
    // In this example, today’s date and a dummy photo object are created.
    // test featch data in view model
    func test_fetch_Product() {
        // When
        sut.initFetchProductData()
    
        // Then
        XCTAssert(apiServiceMock.fetchProductListIsCalled)
    }
    
    // testing fail
        func test_fetch_Product_fail() {
            // Given
            let error = ResoneError.notFound
            // When
            sut.initFetchProductData()
            apiServiceMock.fetchFail(error: error)
            // Then
            XCTAssertEqual(sut.alertMessage, error.rawValue)
        }
    
    // fect data lma bett7t fe cell
    func testCreateCellViewModel() {
        // Given
        //Product details
        let product  = Product(id: 8, productDescription: "details", image: Image(width: 150, height: 300, url: "https://i.picsum.photos/id/609/150/250.jpg?hmac=m3bxhlAF19sxkWdh76Ku2H1xUh4i-s7suLke8_08P3E"), price: 12)

             let cellViewModel = sut?.createCellViewModel(product: product)

        // Then: This is the section where you’ll assert the result you expect with a message that prints if the test fails.
        XCTAssertEqual(cellViewModel?.productDescription, product.productDescription)
        XCTAssertEqual(cellViewModel?.price, product.price)
    }
}
