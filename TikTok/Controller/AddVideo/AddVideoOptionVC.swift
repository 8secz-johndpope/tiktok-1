//
//  AddVideoOptionVC.swift
//  TikTok
//
//  Created by vishal singh on 11/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit

class AddVideoOptionVC: Default {

    @IBOutlet weak var viewNav: NavigationBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design navigation bar
        viewNav.lblTitle.text = "Post"
        viewNav.btnBack.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        viewNav.btnOption.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func uploadImageAction(_ sender: UIButton) {
    }
    @IBAction func uploadVideoAction(_ sender: UIButton) {
    }
    @IBAction func captureImageAction(_ sender: UIButton) {
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "VideoRecorder") as! VideoRecorderVC
        vc.process = "capture"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func recordVideoAction(_ sender: UIButton) {
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "VideoRecorder") as! VideoRecorderVC
        vc.process = "recording"
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
