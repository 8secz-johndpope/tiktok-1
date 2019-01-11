//
//  CommentTableCell.swift
//  TikTok
//
//  Created by vishal singh on 17/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class CommentTableCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnReply: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
