//
//  ProductListCVCell.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 15.02.2023.
//

import UIKit

class ProductListCVCell: UICollectionViewCell {
    var imageView = UIImageView()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    var addToBasketButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width - 1, height: 250))
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 256, width: contentView.bounds.width, height: 20))
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.numberOfLines = 0
        contentView.addSubview(nameLabel)
        
        priceLabel = UILabel(frame: CGRect(x: 10, y: 277, width: contentView.bounds.width, height: 20))
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textColor = .black
        contentView.addSubview(priceLabel)
        
        addToBasketButton = UIButton(type: .system)
        addToBasketButton.setTitle("Sepete Ekle", for: .normal)
        addToBasketButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        addToBasketButton.setTitleColor(.white, for: .normal)
        addToBasketButton.frame = CGRect(x: 0, y: 300 , width:  contentView.bounds.width, height: 40)
        addToBasketButton.configuration?.contentInsets.trailing = 20
        addToBasketButton.configuration?.contentInsets.leading = 20
        addToBasketButton.backgroundColor = UIColor(named: "pazaramaPink")
        addToBasketButton.layer.cornerRadius = 6
        contentView.addSubview(addToBasketButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withData data: Product) {
        let url = URL(string: data.productImages.image1 ?? "")
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        nameLabel.text = data.productName
        priceLabel.text = "\(data.productPrice) TL"
    }
}
