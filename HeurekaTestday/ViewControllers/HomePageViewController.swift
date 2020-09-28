//
//  HomePageViewController.swift
//  HeurekaTestday
//
//  Created by JSE on 30/08/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

  var filter = [Category]()

  @IBOutlet weak var categoryFilterView: UICollectionView!
  @IBOutlet weak var productTableView: UITableView!

  @IBSegueAction func showOffers(_ coder: NSCoder, sender: Any?) -> ProductDetailViewController? {
    guard
      let cell = sender as? ProductsTableViewCell,
      let indexPath = productTableView.indexPath(for: cell)
      else {
        return nil
    }

    productTableView.deselectRow(at: indexPath, animated: true)

    return ProductDetailViewController(coder: coder, product: cell.product!)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
       
    DataProvider.sharedInstance().getCategories()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCategories(notification:)), name: DidReceiveCategories, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProducts(notification:)), name: DidReceiveProducts, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: DidReceiveCategories, object: nil)
    NotificationCenter.default.removeObserver(self, name: DidReceiveProducts, object: nil)
  }
  
  @objc func didReceiveCategories(notification: Notification) {
    categoryFilterView.reloadData()
    DispatchQueue.main.async(execute: { self.updateCategoriesSelection() })
  }

  @objc func didReceiveProducts(notification: Notification) {
    productTableView.reloadData()
  }

  func updateCategoriesSelection() {
    for section in 0...categoryFilterView.numberOfSections-1 {
      for row in 0...categoryFilterView.numberOfItems(inSection: section) {
        if let cell = categoryFilterView.cellForItem(at: IndexPath(row: row, section: section)) as? CategoryCell {
          if cell.category?.categoryId == 0 {
            cell.backgroundColor = filter.isEmpty ? UIColor.systemBlue : UIColor.white
          } else {
            cell.backgroundColor = filter.contains(cell.category!) ? UIColor.systemBlue : UIColor.white
          }
        }
      }
    }
    DataProvider.sharedInstance().getProducts(filter: filter, offset: 0, limit: 50)
  }

  // MARK: - Collection view data source
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let categories = DataProvider.sharedInstance().categories else {
      return 0
    }
    return categories.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = categoryFilterView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
    if let categories = DataProvider.sharedInstance().categories {
      cell.setCategory(categories.sorted()[indexPath.row])
    }
    return cell
  }
  
  // MARK: - Collection view delegate
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 90, height: 145)
  }

  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
    guard let category = cell?.category else {return false}
    if category.categoryId == 0 {
      filter.removeAll()
    } else {
      if filter.contains(category) {
        filter.removeAll( where: {$0 == category} )
      } else {
        filter.append(category)
      }
    }
    updateCategoriesSelection()
    return false
  }
  
  // MARK: - Table view data source
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let products = DataProvider.sharedInstance().products else {
      return 0
    }
    return products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductsTableViewCell
    if let products = DataProvider.sharedInstance().products {
      cell.setProduct(products.sorted()[indexPath.row])
    }
    return cell
  }
  
}
