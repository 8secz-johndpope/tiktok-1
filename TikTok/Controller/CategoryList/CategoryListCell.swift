//
//  CategoryListCell.swift
//  TikTok
//
//  Created by vishal singh on 20/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class CategoryListCell: UITableViewCell {
    @IBOutlet weak var catIcon: UIImageView!
    @IBOutlet weak var catName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
