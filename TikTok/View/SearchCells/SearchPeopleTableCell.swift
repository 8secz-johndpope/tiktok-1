//
//  SearchPeopleTableCell.swift
//  TikTok
//
//  Created by vishal singh on 11/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class SearchPeopleTableCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgProfile.layer.cornerRadius = 35
        btnFollow.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
