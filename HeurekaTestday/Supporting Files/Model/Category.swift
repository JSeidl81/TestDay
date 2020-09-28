//
//  Category.swift
//  HeurekaTestday
//
//  Created by JSE on 13/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

struct Category: Decodable{
  let categoryId: Int
  let title: String
}
  
extension Category: Comparable {
  static func < (lhs: Category, rhs: Category) -> Bool {
      return lhs.categoryId < rhs.categoryId
  }
  
  static func == (lhs: Category, rhs: Category) -> Bool {
    return lhs.categoryId == rhs.categoryId
  }
}
