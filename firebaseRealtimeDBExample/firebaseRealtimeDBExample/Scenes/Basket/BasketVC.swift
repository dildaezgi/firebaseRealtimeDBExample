//
//  BasketVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 14.02.2023.
//

import Foundation
import UIKit

class BasketVC: UIViewController {
    var tableView: UITableView!
    var addedProducts = [[String: Any]]()
    let cellReuseIdentifier = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults'tan sepete eklenen ürünleri almak
        if let addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] {
            self.addedProducts = addedProducts
        }
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(BasketTVCell.self, forCellReuseIdentifier: "BasketTVCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension BasketVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTVCell", for: indexPath) as! BasketTVCell
        
        let product = addedProducts[indexPath.row]
        cell.productImageView.image = UIImage(named: product["image1"] as! String) //sepette tek imageli urunler var bu yuzden ilk image alip ilerleyemiyor. yeni haliyle tum sepeti bosalt ve sonra devam et
        cell.textLabel?.text = product["name"] as? String
        cell.detailTextLabel?.text = "\(product["price"] as? Double ?? 0.0) TL"
        
        //urun silme ve sepeti tamamen bosaltma butonlari olacak
        return cell
        
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
     }
}
