//
//  ProductListViewModel.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 14.02.2023.
//

import Foundation
import Firebase

class ProductListViewModel {
    let databaseRef = Database.database().reference(withPath: "products")
    
    var data: [Product] = []
    var filteredItems: [Product] = []
    
    func fetchObjects(completion: @escaping () -> Void) {
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                return
            }
            for (_, value) in dict {
                if let productDict = value as? [String: Any] {
                    let productName = productDict["productName"] as? String
                    let productPrice = productDict["productPrice"] as? Double
                    let productRate = productDict["productRate"] as? Float
                    let productImagesDict = productDict["productImages"] as? [String: String]
                    let productID = productDict["productID"] as? String
                    
                    let productImages = ProductImages(image1: productImagesDict?["image1"] ?? "", image2: productImagesDict?["image2"] ?? "")
                    let product = Product(productName: productName ?? "", productID: productID ?? "", productPrice: productPrice ?? 0.0, productRate: productRate ?? 0.0, productImages: productImages)
                    self.data.append(product)
                }
            }
            self.filteredItems = self.data
            completion()
        }
    }
}
