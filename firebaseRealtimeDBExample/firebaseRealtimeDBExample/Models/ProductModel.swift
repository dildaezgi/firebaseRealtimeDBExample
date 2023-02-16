//
//  ProductModel.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 14.02.2023.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    let product: Product
}

// MARK: - Product
struct Product: Codable {
//    let productImage: String
    let productName: String
    let productID: String
    let productPrice, productRate: Float
    let productImages: ProductImages
}

// MARK: - ProductImages
struct ProductImages: Codable {
    let image1, image2: String?
}
