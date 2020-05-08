//
//  ItemsCell.swift
//  Finden
//
//  Created by Alan Cao on 5/8/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit

class ItemsCell: UITableViewCell {
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImage.layer.cornerRadius = 150 / 16
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
