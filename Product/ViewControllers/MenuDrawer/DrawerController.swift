//
//  DrawerController.swift
//  SideMenu
//
//  Created by Apple on 11/20/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import LGSideMenuController

class DrawerController: LGSideMenuController {

    private var type: UInt?
    
    func setup(type: UInt) {
        self.type = type
        leftViewController = LeftMenu()
      //  leftViewWidth = 250.0;
        let screenSize = UIScreen.main.bounds
        leftViewWidth = screenSize.width/2 + 100  // set width of the menu drawer
        leftViewBackgroundImage = UIImage(named: "LeftMenu")
        leftViewBackgroundColor = UIColor(red: 0.5, green: 0.65, blue: 0.5, alpha: 0.95)
        let regularStyle: UIBlurEffect.Style
        if #available(iOS 10.0, *) {
            regularStyle = .regular
        }
        else {
            regularStyle = .light
        }
        rootViewCoverBlurEffectForLeftView = UIBlurEffect(style: regularStyle)
        rootViewCoverAlphaForLeftView = 0.8
        self.isLeftViewStatusBarHidden = true
        leftViewPresentationStyle = .slideAbove
        
        
    }
    
    
    override func leftViewWillLayoutSubviews(with size: CGSize) {
        super.leftViewWillLayoutSubviews(with: size)
        
        if !isLeftViewStatusBarHidden {
            leftView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }
    
    override func rightViewWillLayoutSubviews(with size: CGSize) {
        super.rightViewWillLayoutSubviews(with: size)
        
        if (!isRightViewStatusBarHidden ||
            (rightViewAlwaysVisibleOptions.contains(.onPadLandscape) &&
                UI_USER_INTERFACE_IDIOM() == .pad &&
                UIApplication.shared.statusBarOrientation.isLandscape)) {
            rightView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }
    
    override var isLeftViewStatusBarHidden: Bool {
        get {
            if (type == 8) {
                return UIApplication.shared.statusBarOrientation.isLandscape && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isLeftViewStatusBarHidden
        }
        
        set {
            super.isLeftViewStatusBarHidden = newValue
        }
    }
    
    override var isRightViewStatusBarHidden: Bool {
        get {
            if (type == 8) {
                return UIApplication.shared.statusBarOrientation.isLandscape && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isRightViewStatusBarHidden
        }
        
        set {
            super.isRightViewStatusBarHidden = newValue
        }
    }
    
    deinit {
        print("MainViewController deinitialized")
    }
    

}
