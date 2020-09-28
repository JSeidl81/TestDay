//
//  Product.swift
//  HeurekaTestday
//
//  Created by JSE on 31/08/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

struct Product: Decodable {
  let productId: Int
  let title: String
  let categoryId: Int
}

extension Product: Comparable {
  static func < (lhs: Product, rhs: Product) -> Bool {
    return lhs.productId < rhs.productId && lhs.categoryId == lhs.categoryId
  }
  
  static func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.productId == rhs.productId && lhs.categoryId == rhs.categoryId
  }
}
