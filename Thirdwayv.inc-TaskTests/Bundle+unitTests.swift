//
//  Bundle+unitTests.swift
//  Thirdwayv.inc TaskTests
//
//  Created by Abdallah on 1/27/22.
//

import Foundation
extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: APIServiceTests.self)
    }
}

