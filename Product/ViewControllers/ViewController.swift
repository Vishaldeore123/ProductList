//
//  ViewController.swift
//  Product
//
//  Created by Apple on 10/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   var splashScreen:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        self.splashScreen = UIImageView(frame: self.view.frame)
        self.splashScreen.image = UIImage(named: "background.jpg")
        self.view.addSubview(self.splashScreen)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let productListVC = ProductListViewController()
            self.navigationController?.pushViewController(productListVC, animated: true)
        }
    }
}

