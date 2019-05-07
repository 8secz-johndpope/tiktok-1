//
//  NewHome.swift
//  TikTok
//
//  Created by vishal singh on 28/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class NewHome: Default {

    var catIcon = ["cat1","cat2","cat3","cat1","cat2","cat3","cat1","cat2","cat3","cat1","cat2","cat3","cat1","cat2","cat3","cat1"]
    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewInScroll: UIView!
    @IBOutlet weak var banner: UIScrollView!
    @IBOutlet weak var heightInScroll: NSLayoutConstraint!
    @IBOutlet weak var catCollection: UICollectionView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var videoTable: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        heightNav.constant = getDevice()
        heightInScroll.constant = 1280
        self.view.layoutIfNeeded()

        catCollection.delegate = self
        catCollection.dataSource = self
        videoTable.delegate = self
        videoTable.dataSource = self
        // load images on banner
        showBanner()
        //showMenu(menuButton: menuButton)
        
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            //self.revealViewController().rearViewRevealWidth = 260
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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

    @IBAction func showNotification(_ sender: UIButton) {
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "message") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
 
        
        
    }
}
extension NewHome: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = catCollection.dequeueReusableCell(withReuseIdentifier: "catcell", for: indexPath) as! HomeCategoryCell
        cell.backgroundColor = appColor
        cell.cat_icon.image = UIImage.init(named: catIcon[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openvideo"), object: nil, userInfo: nil)

    }
    
    
}
extension NewHome: UITableViewDelegate,UITableViewDataSource{
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
