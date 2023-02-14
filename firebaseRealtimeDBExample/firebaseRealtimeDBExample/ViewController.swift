//
//  ViewController.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 13.02.2023.
//

import FirebaseDatabase
import UIKit

class ViewController: UIViewController {
    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width - 40, height: 50))
        button.setTitle("add entry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }

    @objc private func addNewEntry() {
        let object1: [String: Any] = [
            "productName" : "iPhone X",
            "productPrice" : "10897",
            "productRate" : "5",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product1").setValue(object1)
        
        let object2: [String: Any] = [
            "productName" : "iPhone 11",
            "productPrice" : "15982",
            "productRate" : "3",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product2").setValue(object2)
        
        let object3: [String: Any] = [
            "productName" : "iPhone 12",
            "productPrice" : "22185",
            "productRate" : "1",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product3").setValue(object3)
        
        let object4: [String: Any] = [
            "productName" : "iPhone 13",
            "productPrice" : "29390",
            "productRate" : "4",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product4").setValue(object4)
        
        let object5: [String: Any] = [
            "productName" : "iPhone 13 pro max",
            "productPrice" : "32895",
            "productRate" : "5",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product5").setValue(object5)
        
        let object6: [String: Any] = [
            "productName" : "iPhone 14",
            "productPrice" : "40367",
            "productRate" : "2",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product6").setValue(object6)
        
        let object7: [String: Any] = [
            "productName" : "iPhone 14 pro max",
            "productPrice" : "44062",
            "productRate" : "4",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product7").setValue(object7)
        
        let object8: [String: Any] = [
            "productName" : "Macbook Air",
            "productPrice" : "15.982",
            "productRate" : "1",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product8").setValue(object8)
        
        let object9: [String: Any] = [
            "productName" : "Macbook Pro",
            "productPrice" : "46124",
            "productRate" : "5",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product9").setValue(object9)
        
        let object10: [String: Any] = [
            "productName" : "Apple Watch Series 8",
            "productPrice" : "9999",
            "productRate" : "4",
            "productImage" : "https://d1eh9yux7w8iql.cloudfront.net/product_images/36834_efd45da5-a374-4c62-8b7b-7ceb2c86c0ae.jpg"
        ]
        database.child("product10").setValue(object10)
    }

}

