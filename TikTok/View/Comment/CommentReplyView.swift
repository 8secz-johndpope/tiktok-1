//
//  CommentReplyView.swift
//  TikTok
//
//  Created by vishal singh on 17/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class CommentReplyView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var txtReply: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CommentReplyView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // do your stuff here
        txtReply.layer.cornerRadius = 2
        txtReply.layer.borderColor = UIColor.lightGray.cgColor
        txtReply.layer.borderWidth = 0.5
        btnSend.layer.cornerRadius = 20
    }

}
