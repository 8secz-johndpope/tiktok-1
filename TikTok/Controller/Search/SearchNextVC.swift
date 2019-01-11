//
//  SearchNextVC.swift
//  TikTok
//
//  Created by vishal singh on 11/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class SearchNextVC: Default {

    @IBOutlet weak var navBar: NavigationBarView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewPeople: UIView!
    @IBOutlet weak var tablePeople: UITableView!
    @IBOutlet weak var tabbar: UIView!
    @IBOutlet weak var tabBtnUser: UIButton!
    @IBOutlet weak var tabBtnMusic: UIButton!
    @IBOutlet weak var tabBtnHashtag: UIButton!
    @IBOutlet weak var viewMusic: UIView!
    @IBOutlet weak var tableMusic: UITableView!
    @IBOutlet weak var viewTag: UIView!
    @IBOutlet weak var tableHastag: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.lblTitle.isHidden = true
        navBar.btnOption.isHidden = true
        navBar.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        navBar.addSubview(searchBar)
        setBorder(view: navBar)
        setBorder(view: tabbar)
        tablePeople.delegate = self
        tablePeople.dataSource = self
        tableHastag.delegate = self
        tableHastag.dataSource = self
        tableMusic.delegate = self
        tableMusic.dataSource = self
        
        
      //  viewShadow(view: tabBtnUser)
        
        tablePeople.register(UINib(nibName: "SearchPeopleTableCell", bundle: nil), forCellReuseIdentifier: "peoplecell")
        tableHastag.register(UINib(nibName: "SearchHashtagTableCell", bundle: nil), forCellReuseIdentifier: "hastagcell")
        tableMusic.register(UINib(nibName: "SearchMusicTableCell", bundle: nil), forCellReuseIdentifier: "musiccell")


        navBarHeight.constant = getDevice()
        self.view.layoutIfNeeded()
        

        searchPeople()
        
        // Do any additional setup after loading the view.
    }
    func searchPeople(){
        self.viewPeople.isHidden = false
        self.viewMusic.isHidden = true
        self.viewTag.isHidden = true
        tabBtnUser.alpha = 1.0
        tabBtnMusic.alpha = 0.0
        tabBtnHashtag.alpha = 0.3
       
        tabBtnUser.setImage(UIImage.init(named: "profile_selected"), for: .normal)
        tabBtnMusic.setImage(UIImage.init(named: "music"), for: .normal)
        tabBtnHashtag.setImage(UIImage.init(named: "hashtag"), for: .normal)


    }
    func searchMusic(){
        self.viewPeople.isHidden = true
        self.viewMusic.isHidden = false
        self.viewTag.isHidden = true
        tabBtnUser.alpha = 0.3
        tabBtnMusic.alpha = 1.0
        tabBtnHashtag.alpha = 0.3
        tabBtnUser.setImage(UIImage.init(named: "profile"), for: .normal)
        tabBtnMusic.setImage(UIImage.init(named: "music_selected"), for: .normal)
        tabBtnHashtag.setImage(UIImage.init(named: "hashtag"), for: .normal)

       
    }
    func searchHashtag(){
        self.viewPeople.isHidden = true
        self.viewMusic.isHidden = true
        self.viewTag.isHidden = false
        tabBtnUser.alpha = 0.3
        tabBtnMusic.alpha = 0.0
        tabBtnHashtag.alpha = 1.0
        tabBtnUser.setImage(UIImage.init(named: "profile"), for: .normal)
        tabBtnMusic.setImage(UIImage.init(named: "music"), for: .normal)
        tabBtnHashtag.setImage(UIImage.init(named: "hashtag_selected"), for: .normal)
      

    }
    
    
    @IBAction func searchHashtag(_ sender: UIButton) {
        searchHashtag()
    }
    @IBAction func searchMusic(_ sender: UIButton) {
       // searchMusic()
    }
    
    @IBAction func searchUser(_ sender: UIButton) {
        searchPeople()
    }
    


}
extension SearchNextVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tablePeople {
            let cell = tablePeople.dequeueReusableCell(withIdentifier: "peoplecell", for: indexPath) as! SearchPeopleTableCell
            
            return cell
        }else if tableView == tableMusic {
            let cell = tableMusic.dequeueReusableCell(withIdentifier: "musiccell", for: indexPath) as! SearchMusicTableCell
            
            return cell
        }else{
            let cell = tableHastag.dequeueReusableCell(withIdentifier: "hastagcell", for: indexPath) as! SearchHashtagTableCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tablePeople {
            return 90
            
        }else if tableView == tableMusic {
            return 90
            
        }else{
            return 44

        }
    }
    
}
