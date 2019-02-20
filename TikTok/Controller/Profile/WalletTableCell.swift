//
//  WalletTableCell.swift
//  TikTok
//
//  Created by vishal singh on 08/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class WalletTableCell: UITableViewCell {

    @IBOutlet weak var coinNum: UILabel!
    @IBOutlet weak var coinPrice: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coinPrice.layer.cornerRadius = 4
        coinPrice.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
