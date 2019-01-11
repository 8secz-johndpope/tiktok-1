//
//  LoginPhoneVC.swift
//  TikTok
//
//  Created by vishal singh on 12/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class LoginPhoneVC: Default {

    var process = ""

    
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var lblSingin: UILabel!
    @IBOutlet weak var btnWithEmailPassword: UIButton!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewSignin: UIView!
    @IBOutlet weak var viewOtp: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBorder(view: viewNav)
        viewNav.lblTitle.text = ""
        viewNav.btnOption.isHidden = true
        viewNav.btnBack.addTarget(self, action: #selector(self.backCheckAction), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);

        btnNext.layer.cornerRadius = 4
        
        viewPassword.isHidden = true
        // Do any additional setup after loading the view.
        print("process : ", process)
        viewOtp.isHidden = true

        if process != "signup" {
            viewForSignIn()
        }else{
            viewForSignUp()
        }

    }
   
    @objc func keyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        viewButton.frame.origin.y = displyHeight - (keyboardFrame.size.height + 60)
        

    }
    
    @objc func keyboardHide(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        viewButton.frame.origin.y = displyHeight - 60

    }
    @objc func backCheckAction(){
        print("click back")
        if viewPassword.isHidden == true{
            if viewOtp.isHidden == true {
                self.navigationController?.popViewController(animated: true)
            }else{
                viewOtp.isHidden = true
            }
        }else{
            self.viewPassword.isHidden = true
            
        }
    }

    func viewForSignIn(){
        lblSingin.text = "Sign In"
        btnWithEmailPassword.setTitle("Sign In with email & password", for: .normal)
    }
    
    
    func viewForSignUp(){
        lblSingin.text = "Sign Up"
        btnWithEmailPassword.setTitle("Sign Up with email & password", for: .normal)
    }
    
    @IBAction func emailSignIn(_ sender: UIButton) {
        backAction()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
      
        if lblSingin.text == "Sign In" {
            if viewOtp.isHidden == true {
                viewOtp.isHidden = false
            }else{
                UserDefaults.standard.set("id", forKey: "id")
                // go to video page
                self.goToVideo()
            }

        }else{
            if viewPassword.isHidden != true {
                UserDefaults.standard.set("id", forKey: "id")
                // go to video page
                self.goToVideo()
                
            }else{
                if viewOtp.isHidden == true {
                    viewOtp.isHidden = false
                }else{
                    self.view.addSubview(viewPassword)
                    viewPassword.isHidden = false
                }
                

            }

        }
        
    }
    

}
