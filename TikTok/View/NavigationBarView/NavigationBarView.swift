//
//  NavigationBarView.swift
//  TikTok
//
//  Created by vishal singh on 11/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lblBorder: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // do your stuff here
        lblBorder.frame.size.height = 0.5
    }
    @IBAction func backAction(_ sender: UIButton) {
        
    }
    
}
