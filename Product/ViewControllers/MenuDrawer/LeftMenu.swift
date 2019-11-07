//
//  LeftMenu.swift
//  SideMenu
//
//  Created by Apple on 11/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import LGSideMenuController

class  LeftMenu : UIViewController,UITableViewDelegate,UITableViewDataSource{

    // Data model: These strings will be the data for the table view cells
    let products: [String] = ["Product List", "Favourite Product List"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        // set the text from the data model
        cell.textLabel?.text = self.products[indexPath.row]
        cell.imageView?.image = UIImage(named: "list")
        return cell
    }
   
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainViewController = sideMenuController!
      let navigationController = mainViewController.rootViewController as! ChooseNavigationViewController
        switch indexPath.row {
        case 0:
               let productListVC = ProductListViewController()
               productListVC.title = "Product List"
                navigationController.pushViewController(productListVC, animated: true);
        default:
                 let favouriteProductListVC = ProductDetailsViewController()
                 favouriteProductListVC.title = "Favourite Product List"
                 navigationController.pushViewController(favouriteProductListVC, animated: true)
        }
        mainViewController.hideLeftView(animated: true, completionHandler: nil)
    }

}
