//
//  ProductListTableViewCell.swift
//  Product
//
//  Created by Apple on 10/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var btnDetail: UIButton!
    
    var detailButtonAction : (() -> ())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnDetail.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

@IBAction func detailButtonTapped(_ sender: UIButton){
    // if the closure is defined (not nil)
    // then execute the code inside the subscribeButtonAction closure
    detailButtonAction?()
}
    
   
    
}
