//
//  BasketVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 14.02.2023.
//

import Foundation
import UIKit

class BasketVC: UIViewController {
    var tableView = UITableView()
    var emptyView = EmptyView()
    var addedProducts = [[String: Any]]()
    var totalPrice = 0.0
    
    let cellReuseIdentifier = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] {
            self.addedProducts = addedProducts
        }
        
        if addedProducts.isEmpty {
            emptyView = EmptyView(frame: self.view.frame)
            self.view.addSubview(emptyView)
        } else {
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.register(BasketTVCell.self, forCellReuseIdentifier: "BasketTVCell")
            tableView.delegate = self
            tableView.dataSource = self
            view.addSubview(tableView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if let addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] {
            for product in addedProducts {
                if let price = product["price"] as? Double {
                    totalPrice += price
                }
            }
        }
    }
    
    @objc func deleteProductButtonTapped(sender: UIButton) {
        if let indexPath = tableView.indexPath(for: sender.superview?.superview as! UITableViewCell) {
            var product = addedProducts[indexPath.row]
            product.removeValue(forKey: "basket")
            addedProducts.remove(at: indexPath.row)
            UserDefaults.standard.set(addedProducts, forKey: "basket")
            tableView.deleteRows(at: [indexPath], with: .fade)
            totalPrice = 0
            if let addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] {
                if addedProducts.isEmpty {
                    tableView.isHidden = true
                    emptyView = EmptyView(frame: self.view.frame)
                    self.view.addSubview(emptyView)
                } else {
                    for product in addedProducts {
                        if let price = product["price"] as? Double {
                            totalPrice += price
                        }
                    }
                }
            }
            tableView.reloadData()
        }
    }

    @objc func deleteAllButtonTapped(sender: UIButton) {
        if let indexPath = tableView.indexPath(for: sender.superview?.superview as! UITableViewCell) {
            var product = addedProducts[indexPath.row]
            product.removeValue(forKey: "basket")
            let basket: [[String:Any]] = []
            let updatedBasket = basket.filter { $0["id"] as? String != product["id"] as? String }
            UserDefaults.standard.set(updatedBasket, forKey: "basket")
            addedProducts.removeAll()
            tableView.isHidden = true
            emptyView = EmptyView(frame: self.view.frame)
            self.view.addSubview(emptyView)
        }
    }

}

extension BasketVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTVCell", for: indexPath) as! BasketTVCell
        
        let product = addedProducts[indexPath.row]
        if let imageURL = product["image"] as? String, let stringURL = URL(string: imageURL) {
            cell.productImageView.load(url: stringURL)
        } else {
            //no image from local
        }
        
        cell.nameLabel.text = product["name"] as? String
        cell.priceLabel.text = "\(product["price"] as? Double ?? 0.0) TL"
        
        cell.deleteProductButton.frame = CGRect(x: cell.frame.width - 35, y: cell.frame.height - 35, width: 25, height: 25)
        cell.deleteProductButton.imageView?.image = UIImage(named: "deleteIcon")
        cell.deleteProductButton.addTarget(self, action: #selector(deleteProductButtonTapped), for: .touchUpInside)
        
        cell.deleteAllButton.frame = CGRect(x: cell.frame.width - 150, y: cell.frame.height - 40, width: 100, height: 40)
        cell.deleteAllButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)

        let bottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 100))
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        bottomView.layer.shadowRadius = 4
        bottomView.layer.masksToBounds = false
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        
        let priceLabel = UILabel(frame: CGRect(x: -50, y: 20, width: 150, height: 40))
        priceLabel.text = "\(self.totalPrice) TL"
        priceLabel.textAlignment = .right
        bottomView.addSubview(priceLabel)

        let addToBasketButton = UIButton(frame: CGRect(x: 196, y: 20, width: bottomView.frame.size.width - 220, height: 40))
        addToBasketButton.backgroundColor = .blue
        addToBasketButton.layer.cornerRadius = 6
        addToBasketButton.setTitle("Sepeti Onayla", for: .normal)
        bottomView.addSubview(addToBasketButton)
        
        return cell
        
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
}
