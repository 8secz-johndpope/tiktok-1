//
//  SearchVC.swift
//  TikTok
//
//  Created by vishal singh on 11/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit



class SearchVC: Default,UISearchBarDelegate {
   
    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        viewNav.btnBack.isHidden = true
        viewNav.btnOption.removeFromSuperview()
        viewNav.lblTitle.removeFromSuperview()
        viewNav.addSubview(searchBar)

        heightNav.constant = getDevice()
        self.view.layoutIfNeeded()
        
        
        
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "searchnext") as! SearchNextVC
        navigationController?.pushViewController(vc, animated: true)
        return false
    }
    

}
