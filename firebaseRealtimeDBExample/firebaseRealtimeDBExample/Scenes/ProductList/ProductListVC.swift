//
//  ProductListVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 13.02.2023.
//

import FirebaseDatabase
import Firebase
import UIKit

class ProductListVC: UIViewController {
    let database = Database.database().reference()
    let databaseRef = Database.database().reference(withPath: "products")
    let navigator = Navigator(navigationController: UINavigationController())

    var collectionView: UICollectionView!
    var data: [Product] = []
    
    private let spacing : CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDesign()
        fetchObjects()
        
        let basketButton = UIButton(type: .system)
        basketButton.imageView?.image = UIImage(named: "basketImage")
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
    }
    
    @objc func addToBasketButtonTapped(_ sender: UIButton) {
        print("basildi")

        if let indexPath = collectionView.indexPath(for: sender.superview?.superview as! UICollectionViewCell) {
            let product = data[indexPath.row]

            var addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] ?? []
            
            // Yeni ürünü sepete ekleyin
            let newProduct = ["productID": product.productID, "name": product.productName, "price": product.productPrice, "rate": product.productRate, "image": product.productImage] as [String : Any]
            addedProducts.append(newProduct)
            
            // Sepete eklenen ürünleri güncelleyin
            UserDefaults.standard.set(addedProducts, forKey: "basket")
            
            let basketVC = BasketVC()
            navigator.navigateTo(basketVC, animated: true)
        }
    }
    
    @objc func basketButtonTapped() {
        
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
        
//        let logoView = UIImageView(frame: CGRect(x: 0, y: 50, width: 335, height: 35))
//        let image = UIImage(named: "pazaramaLogo")
//        logoView.image = image
//        view.addSubview(logoView)
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
                    let productID = productDict["productID"] as? String
                    let product = Product(productImage: productImage ?? "", productName: productName ?? "", productID: productID ?? "", productPrice: productPrice ?? 0.0, productRate: productRate ?? 0.0)
                    self.data.append(product)
                }
            }
            self.collectionView.reloadData()
        }
    }
}

extension ProductListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        
        // productImage
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.width - 1, height: 250))
        imageView.layer.cornerRadius = 6
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
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 256, width: cell.contentView.bounds.width, height: 20))
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.text = data[indexPath.row].productName
        cell.contentView.addSubview(nameLabel)

        // productPrice
        let priceLabel = UILabel(frame: CGRect(x: 10, y: 277, width: cell.contentView.bounds.width, height: 20))
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textColor = .black
        priceLabel.text = "\(data[indexPath.row].productPrice) TL"
        cell.contentView.addSubview(priceLabel)
        
       // addToBasketButton SAGDAN SOLDAN BOSLUK VER
        let addToBasketButton = UIButton(type: .system)
        addToBasketButton.setTitle("Sepete Ekle", for: .normal)
        addToBasketButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        addToBasketButton.setTitleColor(.white, for: .normal)
        addToBasketButton.frame = CGRect(x: 0, y: 300 , width:  cell.contentView.bounds.width, height: 40)
        addToBasketButton.configuration?.contentInsets.trailing = 20
        addToBasketButton.configuration?.contentInsets.leading = 20
        addToBasketButton.backgroundColor = UIColor(named: "pazaramaPink")
        addToBasketButton.layer.cornerRadius = 6
        addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped(_:)), for: .touchUpInside)
        cell.contentView.addSubview(addToBasketButton)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = data[indexPath.item]
        let productDetailVC = ProductDetailVC(product: product)
        navigator.navigateTo(productDetailVC, animated: true)
    }
}
