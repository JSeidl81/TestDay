//
//  ProductsTableViewCell.swift
//  HeurekaTestday
//
//  Created by JSE on 31/08/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit

final class ProductsTableViewCell: UITableViewCell {
  var product: Product?
  
  @IBOutlet private weak var borderView: UIView!
  @IBOutlet private weak var productImageView: UIImageView!
  @IBOutlet private weak var productNameLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    borderView.layer.cornerRadius = 45
    borderView.layer.masksToBounds = true

    productImageView.layer.cornerRadius = 41
    productImageView.layer.masksToBounds = true
  }

  func setProduct(_ product: Product) {
    self.product = product
    productNameLabel.text = product.title
    
    if DataProvider.sharedInstance().productImages != nil && DataProvider.sharedInstance().productImages?[product.productId] != nil {
      productImageView.image = DataProvider.sharedInstance().productImages?[product.productId]
    } else {
      switch product.categoryId {
        case 1:
          productImageView.image = UIImage(named: "telephone_80")
        case 2:
          productImageView.image = UIImage(named: "plant_80")
        case 3:
          productImageView.image = UIImage(named: "bell_80")
        default:
          productImageView.image = UIImage(named: "move_80")
      }
    }
  }
}

