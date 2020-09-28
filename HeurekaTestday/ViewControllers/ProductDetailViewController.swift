//
//  ProductDetailViewController.swift
//  HeurekaTestday
//
//  Created by JSE on 13/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private let product: Product

  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var offerTableView: UITableView!
  @IBOutlet weak var productLabel: UILabel!
  
  init?(coder: NSCoder, product: Product) {
    self.product = product
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveOffers(notification:)), name: DidReceiveOffers, object: nil)
    DataProvider.sharedInstance().getOffers(productId: product.productId, offset: 0, limit: 50)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    productLabel.text = product.title
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: DidReceiveOffers, object: nil)
  }

  @objc func didReceiveOffers(notification: Notification) {
    offerTableView.reloadData()

    if DataProvider.sharedInstance().productImages != nil && DataProvider.sharedInstance().productImages?[product.productId] != nil {
      productImage.image = DataProvider.sharedInstance().productImages?[product.productId]
    } else {
      switch product.categoryId {
        case 1:
          productImage.image = UIImage(named: "telephone_80")
        case 2:
          productImage.image = UIImage(named: "plant_80")
        case 3:
          productImage.image = UIImage(named: "bell_80")
        default:
          productImage.image = UIImage(named: "move_80")
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDescriptionSegue" {
      if let descriptionViewController = segue.destination as? DescriptionViewController {
        descriptionViewController.productDescription = (sender as? String)!
      }
    }
  }
  
  // MARK: - Table view data source
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let offers = DataProvider.sharedInstance().offers else {
      return 0
    }
    return offers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = offerTableView.dequeueReusableCell(withIdentifier: "OfferCell") as! OfferTableViewCell
    if let offers = DataProvider.sharedInstance().offers {
      cell.setOffer(offers.sorted()[indexPath.row])
    }
    return cell
  }
  
  // MARK: - Table view delegate
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as? OfferTableViewCell
    offerTableView.deselectRow(at: indexPath, animated: false)
    let showDescriptionActionHandler = { (action:UIAlertAction!) -> Void in
      let alertMessage = UIAlertController(title: "Chyba", message: "Popis nelze zobrazit, protože nebyl zadán.", preferredStyle: .alert)
      alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      if let _:String = cell?.offer?.description {
        self.performSegue(withIdentifier: "ShowDescriptionSegue", sender: cell?.offer?.description)
      } else {
        self.present(alertMessage, animated: true, completion: nil)
      }
    }

    let showDescriptionAction = UIAlertAction(title: "Zobrazit popis", style: UIAlertAction.Style.default, handler: showDescriptionActionHandler)

    let openLinkActionHandler = { (action:UIAlertAction!) -> Void in
      let alertMessage = UIAlertController(title: "Chyba", message: "Odkaz nelze otevřít, protože nebyl zadán.", preferredStyle: .alert)
      alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      if let url = cell?.offer?.url {
        UIApplication.shared.open(URL(string: url)!)
      } else {
        self.present(alertMessage, animated: true, completion: nil)
      }
    }

    let openLinkAction = UIAlertAction(title: "Otevřít odkaz", style: UIAlertAction.Style.default, handler: openLinkActionHandler)

    let optionMenu = UIAlertController(title: nil, message: "Co chcete udělat?", preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "Zrušit", style: .cancel, handler: nil)
    optionMenu.addAction(cancelAction)
    optionMenu.addAction(showDescriptionAction)
    optionMenu.addAction(openLinkAction)

    self.present(optionMenu, animated: true, completion: nil)
  }
  
}
