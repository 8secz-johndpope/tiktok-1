//
//  OptionVC.swift
//  TikTok
//
//  Created by vishal singh on 20/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class OptionVC: Default {

    var header = ["Account","Privacy and security","Support","About"]
    var accountItem = ["Edit profile","Language","Change Password","Logout"]
    var privacyItem = ["Privacy & policy","Faq","Others"]
    var supoortItem = ["Help Center","Report"]
    var AboutItem = ["About Us","Terms of Use"]
    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var tableOption: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOption.delegate = self
        tableOption.dataSource = self
        heightNav.constant = getDevice()
        viewNav.btnOption.removeFromSuperview()
        viewNav.lblTitle.text = "Setting"
        self.view.layoutIfNeeded()
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    

}
extension OptionVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accountItem.count
        case 1:
            return privacyItem.count
        case 2:
            return supoortItem.count
        default:
            return AboutItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableOption.dequeueReusableCell(withIdentifier: "option", for: indexPath) as! OptionTblCell
        
        switch indexPath.section {
        case 0:
            cell.lblName.text = accountItem[indexPath.row]
        case 1:
            cell.lblName.text = privacyItem[indexPath.row]
        case 2:
            cell.lblName.text = supoortItem[indexPath.row]
        default:
            cell.lblName.text = AboutItem[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            self.logoutUser()
        }
    }
    
    
    
}
