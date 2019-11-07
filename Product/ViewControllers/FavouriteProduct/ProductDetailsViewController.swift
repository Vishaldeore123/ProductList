//
//  ProductDetailsViewController.swift
//  Product
//
//  Created by Apple on 10/17/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    var productId = Int()
    var productRating = Int()
    var productTitle = "", productDescription = "",productUpdatedAt =  ""  ,productCreatedAt = "",productImageURL = ""
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var lblProductId: UILabel!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblUpdatedAt: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "Product Details"
        // Do any additional setup after loading the view.
        lblProductTitle.text = productTitle
        lblProductId.text = String(productId)
        lblRating.text = String(productRating)
        lblUpdatedAt.text = productUpdatedAt
        lblCreatedAt.text = productCreatedAt
        lblProductDescription.text = productDescription
        productImageView.load(url: URL(string: productImageURL)!)
    }


  
}
