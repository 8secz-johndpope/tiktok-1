//
//  Default.swift
//  TikTok
//
//  Created by vishal singh on 07/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//00d2fc3
import UIKit

//App color theme
let appColor = UIColor(red:0.04, green:0.06, blue:0.07, alpha:1.0) //090F13


class Default: UIViewController {
    let displyHeight = UIScreen.main.bounds.height
    let displyWidth = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = appColor

        // Do any additional setup after loading the view.
    }
    
    func showMenu(menuButton :UIButton){
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            //self.revealViewController().rearViewRevealWidth = 260
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    func goFirstVC(){
        let borad = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = borad.instantiateViewController(withIdentifier: "firstvc") as! SWRevealViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func backAction(){
        navigationController?.popViewController(animated: true)
    }
    @objc func backToRootAction(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func getDevice() ->CGFloat{
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                return 64
            case 1334:
                print("iPhone 6/6S/7/8")
                return 64
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                return 64
            case 2436:
                print("iPhone X, Xs")
                return 86
            case 2688:
                print("iPhone Xs Max")
                return 86
            case 1792:
                print("iPhone Xr")
                return 86
            default:
                print("Default Case")
                return 64
            }
        }else if UIDevice().userInterfaceIdiom == .pad{
            // for tab
            switch UIScreen.main.nativeBounds.height {
            case 1366:
                print("iPadPro")
                return 64
            case 2732:
                print("iPadPro 12")
                return 64
            default:
                print("Default Case")
                return 64
            }
            
        }else{
            // unspecified
            return 64
        }
    }

    @objc func goToVideo(){
    let board = UIStoryboard.init(name: "Main", bundle: nil)
    let vc = board.instantiateViewController(withIdentifier: "tabbar") as! TabBarController
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToLogin(){
        let board = UIStoryboard.init(name: "Login", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "login") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logoutUser(){
        UserDefaults.standard.removeObject(forKey: "id")
        goToVideo()

    }
    
    func getLogin() -> Bool{
        if  UserDefaults.standard.object(forKey: "id") != nil {
            return true
        }else{
            return false
        }
    }
    
    func viewShadow(view: Any){
        
        (view as AnyObject).layer.masksToBounds = false
        (view as AnyObject).layer.shadowColor = UIColor.gray.cgColor
        (view as AnyObject).layer.shadowOpacity = 0.8
        (view as AnyObject).layer.shadowOffset = CGSize(width: -1, height: 1)
        (view as AnyObject).layer.shadowRadius = 10
        (view as AnyObject).layer.cornerRadius = 10
        
    }
    func setBorder(view: Any){
        
        (view as AnyObject).layer.masksToBounds = false
        (view as AnyObject).layer.borderColor = UIColor.darkGray.cgColor
        (view as AnyObject).layer.borderWidth = 0.5
        
        
    }
    
    // use hex for uicolor
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

