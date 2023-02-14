//
//  BasketVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 14.02.2023.
//

import Foundation
import UIKit

class BasketVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var addedProduts = [String: Int]()
    var tableView: UITableView!
    var addedProducts = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults'tan sepete eklenen ürünleri alın
        if let addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] {
            self.addedProducts = addedProducts
        }
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        // tableView'nun boyutlarını ve konumunu belirleyin
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        // tableView'ı mevcut görünüme ekleyin
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedProduts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        
        let product = addedProducts[indexPath.row]
        cell.textLabel?.text = product["name"] as? String
        cell.detailTextLabel?.text = "\(product["price"] as? Double ?? 0.0) TL"
        
        //urun silme ve sepeti tamamen bosaltma butonlari olacak
        
        return cell
        
    }
}
