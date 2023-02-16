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
    let navigator = Navigator()

    var collectionView: UICollectionView!
    var data: [Product] = []
    
    private let spacing : CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDesign()
        fetchObjects()
        navigator.navController = navigationController!
        let basketButton = UIButton(type: .system)
        basketButton.imageView?.image = UIImage(named: "basketImage")
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigator.setNavigationBarHidden(true, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
//            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.backgroundColor = .white
        } else {
//            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.backgroundColor = .white
        }
    }
    
    @objc func addToBasketButtonTapped(_ sender: UIButton) {
        print("basildi")
        
        if let indexPath = collectionView.indexPath(for: sender.superview?.superview as! UICollectionViewCell) {
            let product = data[indexPath.row]
            
            var addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] ?? []
            
            // Yeni ürünü sepete ekleyin
            let newProduct = ["productID": product.productID, "name": product.productName, "price": product.productPrice, "rate": product.productRate, "image": product.productImages.image1 ?? ""] as [String : Any]
            addedProducts.append(newProduct)
            
            // Sepete eklenen ürünleri güncelleyin
            UserDefaults.standard.set(addedProducts, forKey: "basket")
            
            let basketVC = BasketVC()
            navigator.navigateTo(basketVC, animated: true)
        }
    }
    
    @objc func basketButtonTapped() {
        let basketVC = BasketVC()
        navigator.navigateTo(basketVC, animated: true)
    }
    
    func collectionViewDesign() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing + 44, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
       
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(ProductListCVCell.self, forCellWithReuseIdentifier: "ProductListCVCell")

        
        let navBarView = UIView(frame: CGRect(x: 0, y: 84, width: self.view.frame.width, height: 54))
        navBarView.backgroundColor = .white
        view.addSubview(navBarView)

        let logoView = UIImageView()
        logoView.image = UIImage(named: "pazaramaLogo")
        logoView.backgroundColor = .white
        logoView.frame = CGRect(x: 13, y: 10, width: self.view.frame.width - 200, height: 40)
        navBarView.addSubview(logoView)
        
        let basketButton = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 10, width: 40, height: 40))
        basketButton.setImage(UIImage(named: "basketImage"), for: .normal)
        basketButton.backgroundColor = .white
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        navBarView.addSubview(basketButton)
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
                    let productImagesDict = productDict["productImages"] as? [String: String]
                    let productID = productDict["productID"] as? String
                    
                    let productImages = ProductImages(image1: productImagesDict?["image1"] ?? "", image2: productImagesDict?["image2"] ?? "")
                    let product = Product(productName: productName ?? "", productID: productID ?? "", productPrice: productPrice ?? 0.0, productRate: productRate ?? 0.0, productImages: productImages)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCVCell", for: indexPath) as! ProductListCVCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        cell.addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped(_:)), for: .touchUpInside)
        
        let currentData = data[indexPath.row]
        cell.configure(withData: currentData)
        
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
