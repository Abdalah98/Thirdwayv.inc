//
//  Products.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import Foundation

// MARK: - Product
struct Product: Codable,Hashable  {
    let id: Int
    let productDescription: String
    let image: Image
    let price: Double
}

// MARK: - Image
struct Image: Codable,Hashable {
    let width, height: Double
    let url: String
}

