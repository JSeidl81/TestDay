//
//  Offer.swift
//  HeurekaTestday
//
//  Created by JSE on 13/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

struct Offer: Decodable {
  let offerId: Int
  let productId: Int
  let title: String
  let description: String?
  let url: String
  let imgUrl: String?
  let price: Double
}

extension Offer: Comparable {
  static func < (lhs: Offer, rhs: Offer) -> Bool {
    return lhs.offerId < rhs.offerId && lhs.productId == rhs.productId
  }
  
  static func == (lhs: Offer, rhs: Offer) -> Bool {
    return lhs.offerId == rhs.offerId && lhs.productId == rhs.productId
  }
}

