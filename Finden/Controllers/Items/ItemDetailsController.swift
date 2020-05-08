//
//  ItemDetailsController.swift
//  Finden
//
//  Created by Alan Cao on 5/8/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ItemDetailsController: UIViewController {
    
    // MARK: - Outlets
    
    var items: PFObject!
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemDescription: UITextView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
   func configureUI() {
        let imageFile = items["itemImage"] as! PFFileObject
        guard let urlString = imageFile.url else { return }
        guard let url = URL(string: urlString) else { return }
        
        itemImageView.af_setImage(withURL: url)
        itemNameLabel.text = items["itemName"] as? String ?? ""
        itemDescription.text = items["itemDescription"] as? String ?? ""
        title = items["itemName"] as? String ?? ""
    }
}
