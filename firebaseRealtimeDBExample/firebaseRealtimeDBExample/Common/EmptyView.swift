//
//  EmptyView.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 19.02.2023.
//

import Foundation
import UIKit

class EmptyView: UIView {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Sepetinizde ürün bulunmamaktadır."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyBasketIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(messageLabel)
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 45),
            imageView.heightAnchor.constraint(equalToConstant: 45),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
