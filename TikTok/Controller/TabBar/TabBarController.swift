//
//  TabBarController.swift
//  TikTok
//
//  Created by vishal singh on 10/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class TabBarController: Default {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewTab: TabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTab.btnHome.addTarget(self, action: #selector(showHome), for: .touchUpInside)
        viewTab.btnSearch.addTarget(self, action: #selector(showSearch), for: .touchUpInside)
        viewTab.btnNew.addTarget(self, action: #selector(showNewPost), for: .touchUpInside)
        viewTab.btnMessage.addTarget(self, action: #selector(showMessage), for: .touchUpInside)
        viewTab.btnProfile.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        
        // add observer for show video on tabbar
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify), name: NSNotification.Name(rawValue: "openvideo"), object: nil)

        
        //viewShadow(view: viewTab.btnNew)
        showHome()

        // Do any additional setup after loading the view.
    }
    @objc func doThisWhenNotify() {
        print("openvideo")
        //let info = notification.userInfo
        //load your stuff here
        clearChildVc()
        let vc = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeVC
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.viewContainer.frame.size.width, height: self.viewContainer.frame.size.height)
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        lightTabBar()
        
    }
    
    @objc func showHome(){
        clearChildVc()
        let vc = storyboard?.instantiateViewController(withIdentifier: "newhome") as! NewHome
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.viewContainer.frame.size.width, height: self.viewContainer.frame.size.height)
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        lightTabBar()
    }

    @objc func showSearch(){
        clearChildVc()

        let vc = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchVC
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.viewContainer.frame.size.width, height: self.viewContainer.frame.size.height)
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        lightTabBar()
    }
    @objc func showNewPost(){
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "AddVideoOption") as! AddVideoOptionVC
        self.navigationController?.pushViewController(vc, animated: true)    }
    @objc func showMessage(){

        clearChildVc()
        lightTabBar()

        let vc = storyboard?.instantiateViewController(withIdentifier: "ELearning") as! ELearningVC
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.viewContainer.frame.size.width, height: self.viewContainer.frame.size.height)
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
//        if getLogin() != true{
//            goToLogin()
//        }else{
//            
//        }

        
    }
    @objc func showProfile(){
        clearChildVc()
        lightTabBar()
        viewTab.backgroundColor = appColor
        if getLogin() != true{
            goToLogin()
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
            self.addChildViewController(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.viewContainer.frame.size.width, height: self.viewContainer.frame.size.height)
            self.viewContainer.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        
        
    }
    
    func clearChildVc(){
        viewTab.backgroundColor = UIColor.clear
        if self.childViewControllers.count > 0 {
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
            
        }
    }
    func lightTabBar(){
        viewTab.btnHome.setImage(UIImage.init(named: "home_w"), for: .normal)
        viewTab.btnSearch.setImage(UIImage.init(named: "search_w"), for: .normal)
        //viewTab.btnadd.setImage(UIImage.init(named: "home_w"), for: .normal)
        viewTab.btnMessage.setImage(UIImage.init(named: "message_w"), for: .normal)
        viewTab.btnProfile.setImage(UIImage.init(named: "profile_w"), for: .normal)

    }
    func darkTabBar(){
        viewTab.btnHome.setImage(UIImage.init(named: "home_g"), for: .normal)
        viewTab.btnSearch.setImage(UIImage.init(named: "search_g"), for: .normal)
        //viewTab.btnadd.setImage(UIImage.init(named: "home_w"), for: .normal)
        viewTab.btnMessage.setImage(UIImage.init(named: "message_g"), for: .normal)
        viewTab.btnProfile.setImage(UIImage.init(named: "profile_g"), for: .normal)
    }
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        self.addChildViewController(viewController)
        
        // Add Child View as Subview
        self.view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
}
