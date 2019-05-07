//
//  VideoEditorVC.swift
//  TikTok
//
//  Created by vishal singh on 23/02/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit
import AVKit

class VideoEditorVC: UIViewController {
    
    var videoPath:String?
    var player = AVPlayer()
    var asset:AVAsset?
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    var isPlaying = false


    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var trimmerView: TrimmerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Customise trimer view
        trimmerView.handleColor = UIColor.white
        trimmerView.positionBarColor = UIColor.red
        trimmerView.mainColor
         = UIColor.black
        
        loadVideoRange()
    }
    
    
    
    @IBAction func play(_ sender: Any) {
        
        
        if !isPlaying {
            player.play()
            startPlaybackTimeChecker()
        } else {
            player.pause()
            stopPlaybackTimeChecker()
        }
    }
    
    func loadVideoRange() {
        
        let videoURL = URL.init(fileURLWithPath: videoPath!)
        self.asset = AVAsset(url: videoURL)
        trimmerView.asset = asset
        trimmerView.delegate = self
        addVideoPlayer(with: asset!, playerView: playerView)
    }
    
    private func addVideoPlayer(with asset: AVAsset, playerView: UIView) {
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDidFinishPlaying(_:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        playerView.layer.addSublayer(layer)
    }
    
    @objc func itemDidFinishPlaying(_ notification: Notification) {
        if let startTime = trimmerView.startTime {
            player.seek(to: startTime)
        }
    }
    
    func startPlaybackTimeChecker() {
        
        stopPlaybackTimeChecker()
        playbackTimeCheckerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                                        selector:
            #selector(self.onPlaybackTimeChecker), userInfo: nil, repeats: true)
    }
    
    func stopPlaybackTimeChecker() {
        
        playbackTimeCheckerTimer?.invalidate()
        playbackTimeCheckerTimer = nil
    }
    
    @objc func onPlaybackTimeChecker() {
        
        guard let startTime = trimmerView.startTime, let endTime = trimmerView.endTime else {
            return
        }
        
        let playBackTime = player.currentTime()
        trimmerView.seek(to: playBackTime)
        
        if playBackTime >= endTime {
            player.seek(to: startTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
            trimmerView.seek(to: startTime)
        }
    }

}

extension VideoEditorVC : TrimmerViewDelegate{
    func didChangePositionBar(_ playerTime: CMTime) {
        stopPlaybackTimeChecker()
        player.pause()
        player.seek(to: playerTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        let duration = (trimmerView.endTime! - trimmerView.startTime!).seconds
        print(duration)
    }
    
    func positionBarStoppedMoving(_ playerTime: CMTime) {
        player.seek(to: playerTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        player.play()
        startPlaybackTimeChecker()
    }
    
    
}
