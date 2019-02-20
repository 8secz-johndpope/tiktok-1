//
//  AchievementsTblCell.swift
//  TikTok
//
//  Created by vishal singh on 03/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class AchievementsTblCell: UITableViewCell {
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imgBadge: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.layer.cornerRadius = 4
        viewContent.layer.masksToBounds = false
        viewContent.layer.shadowOpacity = 0.5
        viewContent.layer.shadowColor = UIColor.black.cgColor
        viewContent.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewContent.layer.shadowRadius = 3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
