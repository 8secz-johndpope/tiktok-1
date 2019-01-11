//
//  TabBarView.swift
//  TikTok
//
//  Created by vishal singh on 10/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class TabBarView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("TabBarView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // do your stuff here
    }
    @IBAction func homeAction(_ sender: UIButton) {
    }
    @IBAction func searchAction(_ sender: UIButton) {
    }
    @IBAction func newPostAction(_ sender: UIButton) {
    }
    @IBAction func messageAction(_ sender: UIButton) {
    }
    @IBAction func profileAction(_ sender: UIButton) {
    }
    
    
   

    
    
    
    

}
