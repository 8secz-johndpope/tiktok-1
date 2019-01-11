//
//  LoginVC.swift
//  TikTok
//
//  Created by vishal singh on 07/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class LoginVC: Default {

    
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewSignup: UIView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnHaveAccount: UIButton!
    @IBOutlet weak var btnDontHaveAccount: UIButton!
    @IBOutlet weak var lblSignin: UILabel!
    @IBOutlet weak var txtUsernameSignup: UITextField!
    @IBOutlet weak var txtPasswordSignup: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLogin.layer.cornerRadius = 10

        txtUsername.layer.cornerRadius = 17.5
        txtPassword.layer.cornerRadius = 17.5
        btnSignIn.layer.cornerRadius = 17.5
        txtUsernameSignup.layer.cornerRadius = 17.5
        txtPasswordSignup.layer.cornerRadius = 17.5
        btnSignUp.layer.cornerRadius = 17.5
        btnFacebook.layer.cornerRadius = 20
        btnGoogle.layer.cornerRadius = 20

        viewShadow(view: viewLogin)
        viewShadow(view: viewSignup)
        createBackground()
        self.view.addSubview(btnBack)
        btnBack.addTarget(self, action: #selector(goToVideo), for: .touchUpInside)
        
        btnHaveAccount.isHidden = true
        // Do any additional setup after loading the view.
        
    }
    
    
    
    func createBackground(){
        let firstColor =  UIColor(red:0.00, green:0.00, blue:0.27, alpha:1.0).cgColor
        let secondColor = UIColor(red:0.11, green:0.71, blue:0.88, alpha:1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ secondColor, firstColor]
        gradientLayer.locations = [ 0.0, 1.0]

       // gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
       // gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.addSublayer(gradientLayer)
        self.view.addSubview(viewSignup)
        self.view.addSubview(viewLogin)
        self.view.addSubview(btnFacebook)
        self.view.addSubview(btnGoogle)

    }
    @IBAction func haveAccount(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.view.addSubview(self.viewLogin)
            self.btnHaveAccount.isHidden = true
            //self.btnDontHaveAccount.isHidden = false
            self.lblSignin.isHidden = false
            self.btnDontHaveAccount.setTitle("Don't have an account? SignUp", for: .normal)

        }
        
        
    }
    @IBAction func dontHaveAccount(_ sender: UIButton) {
        
        if btnDontHaveAccount.title(for: .normal) == "Sign Up with Mobile Number"{
            
            let board = UIStoryboard.init(name: "Login", bundle: nil)
            let vc = board.instantiateViewController(withIdentifier: "LoginPhone") as! LoginPhoneVC
            vc.process = "signup"
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            UIView.animate(withDuration: 1.0) {
                self.view.addSubview(self.viewSignup)
                self.btnHaveAccount.isHidden = false
                self.lblSignin.isHidden = true
                //self.btnDontHaveAccount.isHidden = true
                self.btnDontHaveAccount.setTitle("Sign Up with Mobile Number", for: .normal)
            }
        }
        
        
    }
    
    @IBAction func mobileSignIn(_ sender: UIButton) {
       
        let board = UIStoryboard.init(name: "Login", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "LoginPhone") as! LoginPhoneVC
        vc.process = "signin"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signInWithEmail(_ sender: UIButton) {
        UserDefaults.standard.set("id", forKey: "id")

        self.goToVideo()
    }
    @IBAction func signUpWithEmail(_ sender: UIButton) {
        UserDefaults.standard.set("id", forKey: "id")

        self.goToVideo()
    }
    

}
