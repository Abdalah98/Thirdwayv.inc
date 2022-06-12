//
//  StubGenerator.swift
//  MVVMPlaygroundTests
//  Thirdwayv.inc TaskTests
//
//  Created by Abdallah on 1/29/22.
//

import Foundation
@testable import Thirdwayv_inc_Task


class StubGenerator {
    func stubNews() -> [Product]? {
        guard let path = Bundle.unitTest.path(forResource: "products", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let product = try? decoder.decode(Product.self, from: data)
        return product
    }
}
