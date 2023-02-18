//
//  BasketTVCell.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 16.02.2023.
//

import UIKit

class BasketTVCell: UITableViewCell {
    let productImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let deleteProductButton = UIButton()
    let deleteAllButton = UIButton()
    
    var totalPrice = 0.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        productImageView.contentMode = .scaleAspectFit
        contentView.addSubview(productImageView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        
        if let addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] {
            for product in addedProducts {
                if let price = product["price"] as? Double {
                    totalPrice += price
                }
            }
        }
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(priceLabel)
        
        deleteProductButton.setImage(UIImage(named: "deleteIcon"), for: .normal)
        contentView.addSubview(deleteProductButton)
        
        deleteAllButton.setTitle("Hepsini Sil", for: .normal)
        contentView.addSubview(deleteAllButton)

        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 64),
            productImageView.heightAnchor.constraint(equalToConstant: 64),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
