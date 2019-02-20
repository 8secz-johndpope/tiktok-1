//
//  AwardVC.swift
//  TikTok
//
//  Created by vishal singh on 07/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class AwardVC: Default {
    
    var imgArr = ["11","22","33","11","22"]


    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var viewEarning: UIView!
    @IBOutlet weak var ViewInEarning: UIView!
    @IBOutlet weak var tableAward: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNav.lblTitle.text = "Awards"
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        viewNav.btnOption.isHidden = true
        viewEarning.layer.cornerRadius = 10
        viewEarning.clipsToBounds = true
        
        tableAward.delegate = self
        tableAward.dataSource = self
     //   viewEarning.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        earningBackgroundColors()
        viewEarning.addSubview(ViewInEarning)

    }
    func earningBackgroundColors(){
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
    func imageOnEarning(){
        let coinIcon = UIImageView()
        coinIcon.frame = CGRect(x:0, y:0, width:0, height:0)
    }
  
}
extension AwardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAward.dequeueReusableCell(withIdentifier: "AwardTableCell", for: indexPath) as! AwardTableCell
        
        cell.imgStatus.image = UIImage.init(named: imgArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
}
