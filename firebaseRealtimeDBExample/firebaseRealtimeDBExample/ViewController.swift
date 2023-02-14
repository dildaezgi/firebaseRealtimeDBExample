//
//  ViewController.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 13.02.2023.
//

import FirebaseDatabase
import Firebase
import UIKit

class ViewController: UIViewController {
    let database = Database.database().reference()
    let databaseRef = Database.database().reference(withPath: "products")
    var collectionView: UICollectionView!
    var data: [Product] = []
    private let spacing : CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDesign()
        fetchObjects()
    }
    
    func collectionViewDesign() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
       
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    func fetchObjects() {
        // get data from Firebase
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                return
            }
            for (_, value) in dict {
                if let productDict = value as? [String: Any] {
                    let productName = productDict["productName"] as? String
                    let productPrice = productDict["productPrice"] as? Float
                    let productRate = productDict["productRate"] as? Float
                    let productImage = productDict["productImage"] as? String
                    let product = Product(productImage: productImage ?? "", productName: productName ?? "", productPrice: productPrice ?? 0.0, productRate: productRate ?? 0.0)
                    self.data.append(product)
                }
            }
            self.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red

        // productImage
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)

        let url = URL(string: data[indexPath.row].productImage)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
        }

        // productName
        let nameLabel = UILabel(frame: CGRect(x: 0, y: cell.contentView.bounds.height - 70, width: cell.contentView.bounds.width, height: 20))
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.text = data[indexPath.row].productName
        cell.contentView.addSubview(nameLabel)

        // productPrice
        let priceLabel = UILabel(frame: CGRect(x: 0, y: cell.contentView.bounds.height - 20, width: cell.contentView.bounds.width, height: 20))
        priceLabel.textAlignment = .center
        priceLabel.textColor = .gray
        priceLabel.text = "\(data[indexPath.row].productPrice) TL"
        cell.contentView.addSubview(priceLabel)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 200)
    }
}
