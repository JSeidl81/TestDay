//
//  OfferTableViewCell.swift
//  HeurekaTestday
//
//  Created by JSE on 13/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit

final class OfferTableViewCell: UITableViewCell {
  var offer: Offer?
  
  @IBOutlet private weak var offerNameLabel: UILabel!
  @IBOutlet private weak var offerPriceLabel: UILabel!

  func setOffer(_ offer: Offer) {
    self.offer = offer
    offerNameLabel.text = offer.title
    offerPriceLabel.text = "\(offer.price) Kč"
  }
}
