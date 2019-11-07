//
//  Product.swift
//  Product
//
//  Created by Apple on 10/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation


struct  Result {
    let status : Int
    let product : Product
}

// MARK: - DataClass
struct Product {
    let current_page: Int
    let data: [ProductList]
    let first_page_url: String
    let from, last_page: Int
    let last_page_url, next_page_url, path: String
    let per_page: Int
    let to, total: Int
}

// MARK: - Datum
struct ProductList {
    let id: Int
    let title, desciption: String
    let image: String
    let rating, status: Int
    let created_at, updated_at: String
    
    init(jsonData:[String:Any]) {
        id = jsonData["id"] as! Int
        title = jsonData["title"] as! String
        desciption = jsonData["desciption"] as! String
        image = jsonData["image"] as! String
        rating = jsonData["rating"] as! Int
        status = jsonData["status"] as! Int
        created_at = jsonData["created_at"] as! String
        updated_at = jsonData["updated_at"] as! String
    }
}
