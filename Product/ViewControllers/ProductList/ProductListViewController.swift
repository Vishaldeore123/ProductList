//
//  ProductListViewController.swift
//  Product
//
//  Created by Apple on 10/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var arrProductList = [ProductList]()
    var nextPageURL : String = ""
    var lastPage = Int()
    var currentPAge = Int()
    var likes: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "LeftMenu"), style: .plain, target: self, action: #selector(showMenu))
        self.title = "Product List"
        let tableViewCell = UINib(nibName: "ProductListTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "ProductListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        getProductList()
        likes = [String](repeating: "like", count: 20)
       
    }
   
    @objc func showMenu()  {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    
    func getProductList()  {
        let urlString = "http://test.ccube9.com/public/api/product"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let jsonDictionary = jsonResponse as? NSDictionary else {
                        return
                    }
                    guard let jsonArray = jsonDictionary.value(forKeyPath: "data.data")  as? [[String: Any]] else {
                        return
                    }
                    if let nextPage = jsonDictionary.value(forKeyPath: "data.next_page_url") as? String{
                        self.nextPageURL = nextPage
                    }
                    if let lastPage = jsonDictionary.value(forKeyPath: "data.last_page") as? Int{
                        self.lastPage = lastPage
                    }
                    if let currentPage = jsonDictionary.value(forKeyPath: "data.current_page") as? Int{
                        self.currentPAge = currentPage
                    }
                    for dic in jsonArray{
                        self.arrProductList.append(ProductList.init(jsonData: dic))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
            }.resume()
    }
    
    func getMoreProductList()  {
        print(nextPageURL)
        let urlString = nextPageURL
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let jsonDictionary = jsonResponse as? NSDictionary else {
                        return
                    }
                    guard let jsonArray = jsonDictionary.value(forKeyPath: "data.data")  as? [[String: Any]] else {
                        return
                    }
                    if let nextPage = jsonDictionary.value(forKeyPath: "data.next_page_url") as? String{
                        self.nextPageURL = nextPage
                    }
                    if let lastPage = jsonDictionary.value(forKeyPath: "data.last_page") as? Int{
                        self.lastPage = lastPage
                    }
                    if let currentPage = jsonDictionary.value(forKeyPath: "data.current_page") as? Int{
                        self.currentPAge = currentPage
                    }
                    for dic in jsonArray{
                        self.arrProductList.append(ProductList.init(jsonData: dic))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
            }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.arrProductList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier:"ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
            if (self.lastPage != self.currentPAge){
                 getMoreProductList()
            }else{
                print("no more data available")
            }
            return cell
        }
        let cell: ProductListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        cell.productTitle.text = arrProductList[indexPath.row].title
        let imageURL = arrProductList[indexPath.row].image
        cell.productImageView.load(url: URL(string: imageURL)!)
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(likelButtonTapped(_:)), for: .touchUpInside)
        cell.detailButtonAction = { [unowned self] in
            let productDetailVC = ProductDetailsViewController()
            productDetailVC.productTitle = self.arrProductList[indexPath.row].title
             productDetailVC.productId = self.arrProductList[indexPath.row].id
            productDetailVC.productDescription = self.arrProductList[indexPath.row].desciption
             productDetailVC.productRating = self.arrProductList[indexPath.row].rating
            productDetailVC.productCreatedAt = self.arrProductList[indexPath.row].created_at
            productDetailVC.productUpdatedAt = self.arrProductList[indexPath.row].updated_at
             productDetailVC.productImageURL = self.arrProductList[indexPath.row].image
            self.navigationController?.pushViewController(productDetailVC, animated: true)
        }
        return cell
    }
    
    
    @IBAction func likelButtonTapped(_ sender: UIButton){
        if likes[sender.tag] == "like" {
            likes[sender.tag] = "unlike"
            sender.isSelected = false
        }
        else {
            likes[sender.tag] = "like"
            sender.isSelected = true
        }
        sender.setTitle(likes[sender.tag], for:.normal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
