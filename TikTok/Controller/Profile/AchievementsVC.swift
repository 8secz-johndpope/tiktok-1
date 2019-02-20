//
//  AchievementsVC.swift
//  TikTok
//
//  Created by vishal singh on 03/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class AchievementsVC: Default {

    var img = ["badge6","badge5","badge4","badge3","badge2","badge1"]
    @IBOutlet weak var tableAchieve: UITableView!
    @IBOutlet weak var viewNav: NavigationBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableAchieve.delegate = self
        tableAchieve.dataSource = self
        viewNav.lblTitle.text = "Achievements"
        viewNav.btnOption.isHidden = true
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }


}

extension AchievementsVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAchieve.dequeueReusableCell(withIdentifier: "Achievementscell", for: indexPath) as! AchievementsTblCell
        cell.imgBadge.image = UIImage.init(named: img[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
