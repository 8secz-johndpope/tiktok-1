//
//  MessageVC.swift
//  TikTok
//
//  Created by vishal singh on 14/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class NotificationVC: Default {

    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNav.btnOption.isHidden = true
        viewNav.lblTitle.text = "Notifications"
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)

       // setBorder(view: viewNav)
        
        table.delegate = self
        table.dataSource = self
        heightNav.constant = getDevice()
        self.view.layoutIfNeeded()

        // Do any additional setup after loading the view.
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "messagecell", for: indexPath) as! MessageCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
