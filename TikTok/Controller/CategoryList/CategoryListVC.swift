//
//  CategoryListVC.swift
//  TikTok
//
//  Created by vishal singh on 20/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class CategoryListVC: Default {
    
    var catIcon = ["cat1","cat2","cat3","cat1","cat2","cat3","cat1","cat2","cat3","cat1","cat2","cat3","cat1","cat2","cat3","cat1"]

    
    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var tableCat: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCat.delegate = self
        tableCat.dataSource = self
        heightNav.constant = getDevice()
        self.view.layoutIfNeeded()
        viewNav.lblTitle.text = "Select Category"
        viewNav.btnOption.removeFromSuperview()
        showMenu(menuButton: viewNav.btnBack)
       // viewNav.btnBack.addTarget(self, action: #selector(self.showm), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

   

}

extension CategoryListVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catIcon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCat.dequeueReusableCell(withIdentifier: "categorylist", for: indexPath) as! CategoryListCell
        cell.catIcon.image = UIImage.init(named: catIcon[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "home") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
 */
        revealViewController().revealToggle(self)
        //SWRevealViewController.revealToggle(_:)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openvideo"), object: nil, userInfo: nil)
        


        //self.performSegue(withIdentifier: "video", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
