//
//  ChooseNavigationViewController.swift
//  SideMenu
//
//  Created by Apple on 11/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ChooseNavigationViewController: UINavigationController {

    init() {
            super.init(rootViewController: ViewController())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
