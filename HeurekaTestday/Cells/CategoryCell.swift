//
//  CategoryCell.swift
//  HeurekaTestday
//
//  Created by JSE on 13/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
  var category: Category?

  @IBOutlet weak var categoryImageBorderView: UIView!
  @IBOutlet weak var categoryImage: UIImageView!
  @IBOutlet weak var categoryName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    categoryImageBorderView.layer.cornerRadius = 45
    categoryImageBorderView.layer.masksToBounds = true

    categoryImage.layer.cornerRadius = 41
    categoryImage.layer.masksToBounds = true
  }

  func setCategory(_ category: Category) {
    self.category = category
    categoryName.text = category.title
    
    switch category.categoryId {
      case 0:
        categoryImage.image = UIImage(named: "move_80")
      case 1:
        categoryImage.image = UIImage(named: "telephone_80")
      case 2:
        categoryImage.image = UIImage(named: "plant_80")
      case 3:
        categoryImage.image = UIImage(named: "bell_80")
      default:
        categoryImage.image = UIImage(named: "move_80")
    }
  }
  
}
