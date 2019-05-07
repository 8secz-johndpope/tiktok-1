//
//  SideMenuVC.swift
//  TikTok
//
//  Created by vishal singh on 27/04/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class SideMenuVC: Default {

  

        var menuItem = ["Home","Category","Compatition","Setting","Privacy policy","Terms of services","About us"]
        
        
        @IBOutlet weak var tableCat: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableCat.delegate = self
            tableCat.dataSource = self
            
            
        }
        
        
        
    }
    
    extension SideMenuVC : UITableViewDelegate,UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuItem.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableCat.dequeueReusableCell(withIdentifier: "sidemenu", for: indexPath) as! SideMenuCell
//            cell.menuIcon.image = UIImage.init(named: catIcon[indexPath.row])
            cell.menuName.text = menuItem[indexPath.row]
            
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            /* let board = UIStoryboard.init(name: "Main", bundle: nil)
             let vc = board.instantiateViewController(withIdentifier: "home") as! HomeVC
             self.navigationController?.pushViewController(vc, animated: true)
             */
            
            switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: "home", sender: self)
            case 1:
                self.performSegue(withIdentifier: "category", sender: self)
            default:
                return
            }
            
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
}


class SideMenuCell: UITableViewCell {

    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
