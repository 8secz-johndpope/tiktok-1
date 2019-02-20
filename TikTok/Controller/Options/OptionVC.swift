//
//  OptionVC.swift
//  TikTok
//
//  Created by vishal singh on 20/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class OptionVC: Default {

    var header = ["Account","Privacy and security","About"]
    var accountItem = ["Edit profile","Wallet","Achievements","Share Profile","Privacy & Security","Logout"]
    var privacyItem = ["Privacy & policy","Faq","Others"]
    var AboutItem = ["About Us","Help Center","Terms of Use","Report"]
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
        
        switch indexPath.section {
        case 0:
            print("click")
            switch indexPath.row {
            case 0:
                print("click")
                let board = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = board.instantiateViewController(withIdentifier: "updateprofile") as! UpdateProfileVC
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                print("click")
                let board = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = board.instantiateViewController(withIdentifier: "wallet") as! WalletVC
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                print("click")
                let board = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = board.instantiateViewController(withIdentifier: "achievements") as! AchievementsVC
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                print("click")
            default:
                self.logoutUser()
            }
        case 1:
            print("click")
        case 2:
            print("click")
        default:
            print("click")
        }
        
    }
  /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x:0, y:0, width:displyWidth, height:44)) //set these values as necessary
        returnedView.backgroundColor = UIColor.lightGrayColor()
        
        let label = UILabel(frame: CGRectMake(labelX, labelY, labelWidth, labelHeight))
        label.text = self.sectionHeaderTitleArray[section]
        returnedView.addSubview(label)
        
        return returnedView
    }
 */
    
    
    
}
