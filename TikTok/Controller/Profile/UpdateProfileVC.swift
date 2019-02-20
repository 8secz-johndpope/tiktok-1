//
//  UpdateProfileVC.swift
//  TikTok
//
//  Created by vishal singh on 07/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class UpdateProfileVC: Default,UITextViewDelegate {

    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var imgProfilePhoto: UIImageView!
    @IBOutlet weak var txtNickname: UITextField!
    @IBOutlet weak var lblUsername: UITextField!
    @IBOutlet weak var txtBio: UITextView!
    @IBOutlet weak var txtSkills: UITextField!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var viewContent: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtBio.delegate = self
        
        // Custom Navigation
        viewNav.lblTitle.text = "Edit Profile"
    
        viewNav.btnOption.setTitle("Save", for: .normal)
        viewNav.btnOption.setTitleColor(UIColor.white, for: .normal)
        viewNav.btnOption.setImage(nil, for: .normal)
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)

        
        
        // profile photo
        imgProfilePhoto.layer.cornerRadius = 40
    
        txtBio.text = "Bio \nWrite your\nTest description"
        txtBio.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        lblGender.text = "Male"
        lblCountry.text = "India"
        // Do any additional setup after loading the view.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.view.layoutIfNeeded()

    }

    override func viewDidLayoutSubviews() {
        var contentRect = CGRect.zero
        for view in self.viewContent.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.scroll.frame.size = contentRect.size
        print(contentRect.height)
        
    }
  

}
