//
//  WalletVC.swift
//  TikTok
//
//  Created by vishal singh on 08/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class WalletVC: Default {

    var item = ["50","100","200","500","1000","5000"]
    var price = ["35","70","140","350","700","3500"]

    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var viewEarning: UIView!
    @IBOutlet weak var ViewInEarning: UIView!
    
    @IBOutlet weak var tablePack: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tablePack.delegate = self
        tablePack.dataSource = self
        tablePack.tableFooterView = UIView()
        
        viewNav.lblTitle.text = "Wallet"
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        viewNav.btnOption.isHidden = true
        viewEarning.layer.cornerRadius = 10
        viewEarning.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        gradientBackgroundColors()
        viewEarning.addSubview(ViewInEarning)
        
    }
    
    func gradientBackgroundColors(){
        let firstColor =  UIColor(red:0.46, green:0.23, blue:0.53, alpha:1.0).cgColor
        let secondColor = UIColor(red:0.80, green:0.17, blue:0.37, alpha:1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ secondColor, firstColor]
        //  gradientLayer.locations = [ 0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = self.viewEarning.bounds
        
        self.viewEarning.layer.addSublayer(gradientLayer)
    }
  

}
extension WalletVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePack.dequeueReusableCell(withIdentifier: "WalletTableCell", for: indexPath) as! WalletTableCell
        
        cell.coinNum.text = "\(item[indexPath.row]) coins"

        cell.coinPrice.setTitle(" ‎₹ \(price[indexPath.row]).00", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
