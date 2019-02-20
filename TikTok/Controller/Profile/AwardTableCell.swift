//
//  AwardTableCell.swift
//  TikTok
//
//  Created by vishal singh on 07/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class AwardTableCell: UITableViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var imgStatus: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewShadow(view: imgStatus)
        imgBanner.layer.borderWidth = 1
        imgBanner.layer.borderColor = UIColor.white.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewShadow(view: Any){
        
        (view as AnyObject).layer.masksToBounds = false
        (view as AnyObject).layer.shadowColor = UIColor.white.cgColor
        (view as AnyObject).layer.shadowOpacity = 0.5
        (view as AnyObject).layer.shadowOffset = CGSize(width: -1, height: 1)
        (view as AnyObject).layer.shadowRadius = 3
        //(view as AnyObject).layer.cornerRadius = 10
        
    }
}
