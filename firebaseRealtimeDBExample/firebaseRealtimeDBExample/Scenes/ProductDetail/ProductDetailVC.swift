//
//  ProductDetailVC.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 13.02.2023.
//

import UIKit

class ProductDetailVC: UIViewController {
    let product: Product
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        customView.backgroundColor = .white
        view.addSubview(customView)
        
        navigationController?.navigationBar.backgroundColor = .white
        
        // Set up scroll view
        scrollView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height / 2)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height)
        scrollView.delegate = self
        
        // Add image views to scroll view
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height))
        imageView1.contentMode = .scaleAspectFit
        
        if let image1string = URL(string: product.productImages.image1 ?? "") {
            imageView1.load(url: image1string)
        }
        scrollView.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height))
        imageView2.contentMode = .scaleAspectFit
        if let image2string = URL(string: product.productImages.image2 ?? "") {
            imageView2.load(url: image2string)
        }
        scrollView.addSubview(imageView2)
        
        view.addSubview(scrollView)
        
        // Set up page control
        pageControl.frame = CGRect(x: 0, y: scrollView.frame.maxY, width: view.frame.width, height: 50)
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        view.addSubview(pageControl)
        
        productNameLabel.text = product.productName
        productNameLabel.textColor = .black
        productNameLabel.font = .systemFont(ofSize: 20)
        productNameLabel.sizeToFit()
        productNameLabel.numberOfLines = 0
        productNameLabel.frame = CGRect(x: 16, y: 585, width: self.view.frame.width - 16, height: 60)
        view.addSubview(productNameLabel)
        
        titleLabel.text = "Ürün Açıklaması"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        titleLabel.frame = CGRect(x: 16, y: 635, width: self.view.frame.width - 16, height: 60)
        view.addSubview(titleLabel)
        
        descriptionLabel.text = "Ürünlerimizin çevre etkisini azaltmaya yardımcı olan teknolojiler ve ham maddeler kullanılarak imal edilen kıyafetleri Join Life olarak etiketlendiriyoruz..."
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 16, y: 685, width: self.view.frame.width - 16, height: 60)
        view.addSubview(descriptionLabel)
        
        // Sabit view'i oluşturma
        let bottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 100))
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        bottomView.layer.shadowRadius = 4
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
    
    @objc func addToBasketButtonTapped(_ sender: UIButton) {
        print("basildi")

        var addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] ?? []
        
        // Yeni ürünü sepete eklemek
        let newProduct = ["productID": product.productID, "name": product.productName, "price": product.productPrice, "rate": product.productRate, "image": product.productImages.image1 ?? ""] as [String : Any]
        addedProducts.append(newProduct)
        
        // Sepete eklenen ürünleri güncellemek
        UserDefaults.standard.set(addedProducts, forKey: "basket")
    }
}

extension ProductDetailVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl.currentPage = pageNumber
    }
}

