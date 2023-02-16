//
//  ProductDetailVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 13.02.2023.
//

import UIKit

class ProductDetailVC: UIViewController {
    let product: Product
    var productNameLabel = UILabel()
    var productImage1 = UIImageView()
    var productImage2 = UIImageView()
    var priceLabel = UILabel()
    var descriptionLabel = UILabel()
    var titleLabel = UILabel()

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        customView.backgroundColor = .lightGray
        view.addSubview(customView)
        
        navigationController?.navigationBar.backgroundColor = .white
        
        setupScrollView()
        setupPageControl()

        if let imageURL1 = product.productImages.image1, let stringURL1 = URL(string: imageURL1) {
            productImage1.load(url: stringURL1)
        }
        
        if let imageURL2 = product.productImages.image1, let stringURL2 = URL(string: imageURL2) {
            productImage2.load(url: stringURL2)
        }
        
//        productImage1.frame = CGRect(x: 0, y: 44, width: self.view.frame.width, height: 385)

        productNameLabel.text = product.productName
        productNameLabel.textColor = .black
        productNameLabel.font = .systemFont(ofSize: 20)
        productNameLabel.sizeToFit()
        productNameLabel.numberOfLines = 0
        productNameLabel.frame = CGRect(x: 16, y: 485, width: self.view.frame.width - 16, height: 60)
        view.addSubview(productNameLabel)
        
        titleLabel.text = "Ürün Açıklaması"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        titleLabel.frame = CGRect(x: 16, y: 535, width: self.view.frame.width - 16, height: 60)
        view.addSubview(titleLabel)
        
        descriptionLabel.text = "Ürünlerimizin çevre etkisini azaltmaya yardımcı olan teknolojiler ve ham maddeler kullanılarak imal edilen kıyafetleri Join Life olarak etiketlendiriyoruz..."
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 16, y: 585, width: self.view.frame.width - 16, height: 60)
        view.addSubview(descriptionLabel)
        
        // Sabit view'i oluşturma
        let bottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 100))
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        
        // Ürün fiyatı label'ı
        let priceLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 150, height: 40))
        priceLabel.text = "\(product.productPrice) TL"
        priceLabel.textAlignment = .right
        bottomView.addSubview(priceLabel)

        // Sepete ekle butonu
        let addToBasketButton = UIButton(frame: CGRect(x: 196, y: 20, width: bottomView.frame.size.width - 220, height: 40))
        addToBasketButton.backgroundColor = .blue
        addToBasketButton.layer.cornerRadius = 6
        addToBasketButton.setTitle("Sepete Ekle", for: .normal)
        addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped), for: .touchUpInside)
        bottomView.addSubview(addToBasketButton)
    }
    
    func setupView() {
        
    }
    
    @objc func addToBasketButtonTapped(_ sender: UIButton) {
        print("basildi")

        var addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] ?? []
        
        // Yeni ürünü sepete ekleyin
        let newProduct = ["productID": product.productID, "name": product.productName, "price": product.productPrice, "rate": product.productRate, "image": product.productImages.image1 ?? ""] as [String : Any]
        addedProducts.append(newProduct)
        
        // Sepete eklenen ürünleri güncelleyin
        UserDefaults.standard.set(addedProducts, forKey: "basket")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
         let pageControl = UIPageControl()
         pageControl.pageIndicatorTintColor = .lightGray
         pageControl.currentPageIndicatorTintColor = .black
         return pageControl
     }()
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        let imageViews = [product.productImages.image1, product.productImages.image2]
        //imagelar nasil alinicak?
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = 2 // veya resim sayısı kadar olabilir
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}

