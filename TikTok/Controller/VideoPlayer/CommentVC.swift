//
//  CommentVC.swift
//  TikTok
//
//  Created by vishal singh on 17/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class CommentVC: Default {

    var testData = ["test comment \n test", "test abc","test comment \n test test comment \n test","test comment \n test", "test abc","test comment \n test test comment \n test","test comment \n test", "test abc","test comment \n test test comment \n test", "test comment \n test", "test abc","test comment \n test test comment \n test","test comment \n test", "test abc","test comment \n test test comment \n test"]
    
    var selected : Int?
    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var tableComment: UITableView!
    @IBOutlet weak var viewReply: CommentReplyView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableComment.delegate = self
        tableComment.dataSource = self
        viewNav.lblTitle.text = "Comments"
        viewNav.btnOption.isHidden = true
       // setBorder(view: viewNav)
        tableComment.register(UINib(nibName: "CommentTableCell", bundle: nil), forCellReuseIdentifier: "commenttablecell")
        
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        

        setBorder(view: viewReply)
        heightNav.constant = getDevice()
        self.view.layoutIfNeeded()

        // Do any additional setup after loading the view.
    }

    @objc func replyComment(sender: UIButton){
        tableComment.reloadData()
      //  tableComment.reloadRows(at: [selected!], with: UITableViewRowAnimation.automatic)
        
        
    }
   

}

extension CommentVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableComment.dequeueReusableCell(withIdentifier: "commenttablecell", for: indexPath) as! CommentTableCell
        cell.lblComment.text = testData[indexPath.row]
        cell.btnReply.tag = indexPath.row
        cell.btnReply.addTarget(self, action: #selector(self.replyComment(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selected {
            return UITableViewAutomaticDimension + 100

        }else{
            return UITableViewAutomaticDimension

        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
