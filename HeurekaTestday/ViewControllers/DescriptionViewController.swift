//
//  DescriptionViewController.swift
//  HeurekaTestday
//
//  Created by JSE on 28/09/2020.
//  Copyright © 2020 Hany Co. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
  var productDescription: String = ""
  
  @IBOutlet weak var descriptionTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    descriptionTextView.text += productDescription
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

}
