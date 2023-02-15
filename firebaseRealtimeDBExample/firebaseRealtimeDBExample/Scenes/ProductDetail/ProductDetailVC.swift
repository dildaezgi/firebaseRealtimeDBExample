//
//  ProductDetailVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 13.02.2023.
//

import UIKit

class ProductDetailVC: UIViewController {
    let product: Product
    let productNameLabel = UILabel()
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        // View oluşturma
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        customView.backgroundColor = .white
        
        // View ekleme
        view.addSubview(customView)
        
        // Label ayarları
        productNameLabel.text = product.productName
        productNameLabel.textColor = .black
        productNameLabel.font = .systemFont(ofSize: 18)
        productNameLabel.sizeToFit()
        
        // Label konumlandırma
        productNameLabel.center = CGPoint(x: view.frame.width / 2, y: 100)
        
        // Label ekleme
        view.addSubview(productNameLabel)
    }
    
    // ...
}
