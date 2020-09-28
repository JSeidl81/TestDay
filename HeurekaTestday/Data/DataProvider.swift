//
//  DataProvider.swift
//  HeurekaTestday
//
//  Created by JSE on 13/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit
import Alamofire

let DidReceiveCategories = Notification.Name(rawValue: "DidReceiveCategories")
let DidReceiveProducts = Notification.Name(rawValue: "DidReceiveProducts")
let DidReceiveOffers = Notification.Name(rawValue: "DidReceiveOffers")

class DataProvider {
  let dataURLBase = "https://heureka-testday.herokuapp.com"

  struct StaticInstance{
    static var instance: DataProvider?
  }

  class func sharedInstance() -> DataProvider {
    if !(StaticInstance.instance != nil){
      StaticInstance.instance = DataProvider()
    }
    return StaticInstance.instance!
  }
  
  var categories: [Category]?
  var products: [Product]?
  var offers: [Offer]?
  var productImages: [Int: UIImage]?
  
  func getCategories() {
    var recievedCategories = [Category]()
    
    let request = AF.request("\(dataURLBase)/categories/")

    request.responseDecodable(of: [Category].self) { (response) in
      guard let categoriesData = response.value else {
        print("No category data!")
        return
      }

      recievedCategories.append(Category(categoryId: 0, title: "Vše"))
      
      for category in categoriesData {
        print(category)
        recievedCategories.append(category)
      }
      
      self.categories = recievedCategories
      NotificationCenter.default.post(name: DidReceiveCategories, object: nil)
    }
  }
  
  func getProducts(filter: [Category], offset: Int, limit: Int) {
    var receivedProducts = [Product]()
    let categories: [Category] = (filter.isEmpty ? self.categories : filter)!
    for category in categories {
      if category.categoryId == 0 {
        continue
      }
      let request = AF.request("\(dataURLBase)/products/\(category.categoryId)/\(offset)/\(limit)/")

      request.responseDecodable(of: [Product].self) { (response) in
        guard let productsData = response.value else {
          print("No product data for categoryId \(category.categoryId)!")
          return
        }

        for product in productsData {
          print(product)
        }
        
        receivedProducts.append(contentsOf: productsData)
        self.products = receivedProducts
        NotificationCenter.default.post(name: DidReceiveProducts, object: nil)
      }
    }
  }
  
  func getOffers(productId: Int, offset: Int, limit: Int) {
    let request = AF.request("\(dataURLBase)/offers/\(productId)/\(offset)/\(limit)/")

    request.responseDecodable(of: [Offer].self) { (response) in
      guard let offersData = response.value else {
        print("No offers data for productId \(productId)!")
        return
      }

      for offer in offersData {
        print(offer)
      }

      self.offers = offersData
      NotificationCenter.default.post(name: DidReceiveOffers, object: nil)
    }
  }

  func getProductImages() {
    // TODO
  }
}
