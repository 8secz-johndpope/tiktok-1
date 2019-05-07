//
//  ELearningVC.swift
//  TikTok
//
//  Created by vishal singh on 08/05/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class ELearningVC: Default {

    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewInScroll: UIView!
    @IBOutlet weak var banner: UIScrollView!
    @IBOutlet weak var heightInScroll: NSLayoutConstraint!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var videoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightNav.constant = getDevice()
        viewNav.lblTitle.text = "E-Learning"
        viewNav.btnBack.isHidden = true
        heightInScroll.constant = 1280
        self.view.layoutIfNeeded()
        
        videoTable.delegate = self
        videoTable.dataSource = self
        // load images on banner
        showBanner()
        //showMenu(menuButton: menuButton)
        
        
    }
    
    func showBanner(){
        
        if let image2 = UIImage(named: "banner2") {
            banner.auk.show(image: image2)
        }
        if let image3 = UIImage(named: "banner3") {
            banner.auk.show(image: image3)
        }
        if let image4 = UIImage(named: "banner4") {
            banner.auk.show(image: image4)
        }
    }

   

}

extension ELearningVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // viewContent.frame.size.height = 7 * 180
        // self.view.layoutIfNeeded()
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTable.dequeueReusableCell(withIdentifier: "videocell", for: indexPath) as! HomeVideoTblCell
        
        return cell
    }
    
    
}
