//
//  HomeVC.swift
//  TikTok
//
//  Created by vishal singh on 05/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit
import AVKit
//import AVFoundation

class HomeVC: Default {

    var player = AVPlayer()
    let playerLayer = AVPlayerLayer()

    
    var index = 0
    
    // outlets for HomeVC
    @IBOutlet weak var dummy: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var heightViewProfile: NSLayoutConstraint!
    @IBOutlet weak var imgPlus: UIImageView!
    
    @IBOutlet weak var imgPlay: UIImageView!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var lblFilter: UILabel!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var filterXcontent: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
       // dummy.isHidden = true
        
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("This is my first video ")
            .bold("#hashtag")
            .normal(" This is my first video ")
            .bold("#hashtag")
            .normal(" This is my first video ")
            .bold("#hashtag")
            .normal(" This is my first video ")
            .bold("#hashtag")
        
        
        txtDescription.attributedText = formattedString
        
        imgPlus.layer.cornerRadius = 7.5

        viewProfile.layer.cornerRadius = 22.5
        
        
        viewProfile.layer.borderColor = UIColor.white.cgColor
        viewProfile.layer.borderWidth = 0.5
        //Play video in loop
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            self?.player.seek(to: kCMTimeZero)
            self?.player.play()
        }

        let singleTap: UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(self.playPause))
        singleTap.numberOfTapsRequired = 1
        self.viewContent.addGestureRecognizer(singleTap)
        
        // Double Tap
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.like))
        doubleTap.numberOfTapsRequired = 2
        self.viewContent.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
        singleTap.delaysTouchesBegan = true
        doubleTap.delaysTouchesBegan = true
     
        // show comments on click
       // btnComment.addTarget(self, action: #selector(self.showComments), for: .touchUpInside)
        
        heightViewProfile.constant = getDevice() - 36
        self.view.layoutIfNeeded()
        
        // swipe up and down gesture
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.viewContent.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.viewContent.addGestureRecognizer(swipeDown)

        createPlayer(url: "http://203.76.249.210:8000/public/raw/video2.mp4")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player.play()


    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player.pause()
    }

    func createPlayer(url : String){
        let videoURL = URL(string: url)
        player = AVPlayer(url: videoURL!)
        playerLayer.player = player
        //playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }catch{
            print("catch")
        }
       // playerLayer.videoGravity = AVLayerVideoGravity(rawValue: kCAGravityCenter)
        playerLayer.backgroundColor = UIColor.black.cgColor
        self.viewPlayer.layer.addSublayer(playerLayer)
        player.play()
        
        self.imgPlay.alpha = 0.0

    }
    @objc func showComments(){
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "comment") as! CommentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func playNext(){
        player.pause()
        createPlayer(url: "http://203.76.249.210:8000/public/raw/video1.mp4")
       
    }
    
    func playPrev(){
        player.pause()
        createPlayer(url: "http://203.76.249.210:8000/public/raw/video3.mp4")

    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                swipeDownAction()
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                swipeUPAction()

            default:
                break
            }
        }
    }
        
    
    func swipeDownAction(){
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromBottom
            transition.duration = 0.5
            viewMain.layer.add(transition, forKey: nil)
            playPrev()
       
        
    }
    
    func swipeUPAction(){
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
            transition.duration = 0.5
            viewMain.layer.add(transition, forKey: nil)
            playNext()
       
        
    }
        
    @objc func playPause(){
        UIView.animate(withDuration: 0.5) {
            if self.imgPlay
                .alpha == 0 {
                self.imgPlay.alpha = 0.5
                self.player.pause()
                print("pause")

            }else{
                self.imgPlay.alpha = 0.0
                self.player.play()
                print("play")

            }
        }
        
    }
    
    @objc func like(){
        print("like")
       btnLike.imageView?.image = UIImage.init(named: "heart_red")
        
        dummy.isHidden = true
        
    }
    
    

    @IBAction func showCategoryAction(_ sender: UIButton) {
        player.pause()
       goFirstVC()
        //self.navigationController?.popViewController(animated: true)
    }
    @IBAction func showFilterAction(_ sender: UIButton) {
        player.pause()

        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "filter") as! FilterVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func likeAction(_ sender: UIButton) {
        self.view.makeToast("liked")
    }
    @IBAction func showComment(_ sender: UIButton) {
        showComments()
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
    }
    @IBAction func giftAction(_ sender: DesignableButton) {
        self.view.makeToast("gifted")

    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Bold", size: 14)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
