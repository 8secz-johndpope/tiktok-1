//
//  VideoConatinerVC.swift
//  TikTok
//
//  Created by vishal singh on 19/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class VideoContainerVC: Default {

    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnClose.layer.cornerRadius = 17.5
        btnRecord.layer.cornerRadius = 25
        btnClose.addTarget(self, action: #selector(self.closeView), for: .touchUpInside)
        btnGallery.addTarget(self, action: #selector(self.showOption), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

   @objc func closeView(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func showOption(){
        
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        
        AttachmentHandler.shared.videoPickedBlock = { (video) in
            // get your video here
            print("image video picked")

        }
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            print("image picked")
            /* get your image here */
        }

    }
    
    
    
    @IBAction func recordAction(_ sender: UIButton) {
        
    }
    
}
