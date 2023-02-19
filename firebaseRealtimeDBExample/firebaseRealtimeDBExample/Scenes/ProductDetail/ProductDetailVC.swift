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
        setupView()
    }
    
    @objc func addToBasketButtonTapped(_ sender: UIButton) {
        var addedProducts = UserDefaults.standard.array(forKey: "basket") as? [[String: Any]] ?? []
        let newProduct = ["productID": product.productID, "name": product.productName, "price": product.productPrice, "rate": product.productRate, "image": product.productImages.image1 ?? ""] as [String : Any]
        addedProducts.append(newProduct)
        UserDefaults.standard.set(addedProducts, forKey: "basket")
    }
    
    func setupView() {
        let customView = UIView(frame: .zero)
        customView.backgroundColor = .white
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationController?.navigationBar.backgroundColor = .white
        
        scrollView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height / 2)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height)
        scrollView.delegate = self
        
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
        
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        productNameLabel.text = product.productName
        productNameLabel.textColor = .black
        productNameLabel.font = .systemFont(ofSize: 20)
        productNameLabel.numberOfLines = 0
        view.addSubview(productNameLabel)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productNameLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 5),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productNameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        titleLabel.text = "Ürün Açıklaması"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        descriptionLabel.text = "Ürünlerimizin çevre etkisini azaltmaya yardımcı olan teknolojiler ve ham maddeler kullanılarak imal edilen kıyafetleri Join Life olarak etiketlendiriyoruz..."
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
        
        let bottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 100))
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        bottomView.layer.shadowRadius = 4
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        
        let priceLabel = UILabel(frame: CGRect(x: -50, y: 20, width: 150, height: 40))
        priceLabel.text = "\(product.productPrice) TL"
        priceLabel.textAlignment = .right
        bottomView.addSubview(priceLabel)
        
        let addToBasketButton = UIButton(frame: CGRect(x: 196, y: 20, width: bottomView.frame.size.width - 220, height: 40))
        addToBasketButton.backgroundColor = .blue
        addToBasketButton.layer.cornerRadius = 6
        addToBasketButton.setTitle("Sepete Ekle", for: .normal)
        addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped), for: .touchUpInside)
        bottomView.addSubview(addToBasketButton)
    }
}

extension ProductDetailVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl.currentPage = pageNumber
    }
}

