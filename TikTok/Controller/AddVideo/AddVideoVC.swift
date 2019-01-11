//
//  AddVideoVC.swift
//  TikTok
//
//  Created by vishal singh on 18/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//https://github.com/dev-labs-bg/swift-video-generator

import UIKit
import AVFoundation
import ReplayKit
import Photos

class AddVideoVC: Default, AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("finesh recording")
        UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil)
    }
    

    var videoGenerator: VideoGenerator?
    var delegate : AVCaptureFileOutputRecordingDelegate?
    var fileOutput : AVCaptureMovieFileOutput!
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    
    let recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
 
    
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var viewController: UIView!
    @IBOutlet weak var viewOption: UIView!
    @IBOutlet weak var viewCapture: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.viewPreview.backgroundColor = UIColor.black
        //self.viewController.backgroundColor = UIColor.red

        viewOption.backgroundColor = UIColor.clear
        viewCapture.isHidden = true
   
        showPreview()
        
    }
    
    var images = [Any]()
    var limit = 20
    
    func capture() {
        
        if limit > 0 {
            
            delay(0.005) {
                
                self.screenshot()
                print("capture")
                self.capture()
                
            }
        }else {
            
            print("arr",images)
            convrtToVideo()
            
            }
        
    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func screenshot()  {
        
        var imageSize = CGSize.zero
        
        let orientation = UIApplication.shared.statusBarOrientation
        if UIInterfaceOrientationIsPortrait(orientation) {
            imageSize = UIScreen.main.nativeBounds.size
            print("portrait",imageSize)
        } else {
            imageSize = CGSize(width: UIScreen.main.nativeBounds.size.height, height: UIScreen.main.nativeBounds.size.width)
            print("landscape",imageSize)

        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        for window in UIApplication.shared.windows {
            window.drawHierarchy(in: viewPreview.bounds, afterScreenUpdates: true)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        images.append(image!)
        
        
        limit = limit - 1
        
    }
    
    func convrtToVideo(){
        
        if let audioURL1 = Bundle.main.url(forResource: "audio1", withExtension: ".mp3") {
           // LoadingView.lockView()
            
            VideoGenerator.current.fileName = "nextfile"
            VideoGenerator.current.shouldOptimiseImageForVideo = true
            VideoGenerator.current.maxVideoLengthInSeconds = 30
            VideoGenerator.current.videoBackgroundColor = UIColor.white
        
            
            VideoGenerator.current.generate(withImages: images as! [UIImage], andAudios: [audioURL1], andType: .singleAudioMultipleImage, { (progress) in
                print(progress)
            }, success: { (url) in
               // LoadingView.unlockView()
                print(url)
             //   self.createAlertView(message: self.FnishedMultipleVideoGeneration)
            }, failure: { (error) in
             //   LoadingView.unlockView()
                print(error)
              //  self.createAlertView(message: error.localizedDescription)
            })
        }
       
        
    }
    
   
    func showPreview(){
        let devices = AVCaptureDevice.devices().filter{ $0.hasMediaType(AVMediaType.video) && $0.position == AVCaptureDevice.Position.back }
        
        if let captureDevice = devices.first  {
            do{
                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            }catch{
                print("error")
            }
            captureSession.sessionPreset = AVCaptureSession.Preset.high
            
            //Add File Output
            self.fileOutput = AVCaptureMovieFileOutput()
            captureSession.addOutput(fileOutput)
            
            // show preview
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.bounds = view.bounds
            previewLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            viewPreview.layer.addSublayer(previewLayer)
  
            captureSession.startRunning()
        }
    }
    
    
    func startRecording() {
        
        guard recorder.isAvailable else {
            print("Recording is not available at this time.")
            return
        }
        
        if #available(iOS 10.0, *) {
            recorder.startRecording{ [unowned self] (error) in
                
                guard error == nil else {
                    print("There was an error starting the recording.")
                    return
                }
                
                print("Started Recording Successfully")
                
                self.recorder.isMicrophoneEnabled = true
                self.isRecording = true
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    func stopRecording() {
        print("Stop press")
        RPScreenRecorder.shared().stopRecording { (previewController, error) in
            
            if previewController != nil {
                self.isRecording = false
                
                let alertController = UIAlertController(title: "Recording", message: "Do you wish to discard or view your gameplay recording?", preferredStyle: .alert)
                
                let discardAction = UIAlertAction(title: "Discard", style: .default) { (action: UIAlertAction) in
                    RPScreenRecorder.shared().discardRecording(handler: { () -> Void in
                        // Executed once recording has successfully been discarded
                    })
                }
                
                let viewAction = UIAlertAction(title: "View", style: .default, handler: { (action: UIAlertAction) -> Void in
                    self.present(previewController!, animated: true, completion: nil)
                })
                
                alertController.addAction(discardAction)
                alertController.addAction(viewAction)
                
                self.present(alertController, animated: true, completion: nil)
                
         
                
            } else {
                // Handle error
            }
        }
        
        
    }
  
    
    @IBAction func recordVideoAction(_ sender: UIButton) {
        viewCapture.isHidden = false
        self.viewCapture.backgroundColor = UIColor.clear
        viewOption.removeFromSuperview()
    }
    @IBAction func captureVideo(_ sender: UIButton) {
      /*  if isRecording != true {
            startRecording()
        }else{
            stopRecording()
        }
        
    
 */
        capture()

    }

    // convert image array in video
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
}

struct RenderSettings {
    
    var size : CGSize = .zero
    var fps: Int32 = 6   // frames per second
    var avCodecKey = AVVideoCodecH264
    var videoFilename = "render"
    var videoFilenameExt = "mp4"
    
    
    var outputURL: URL {
        // Use the CachesDirectory so the rendered video file sticks around as long as we need it to.
        // Using the CachesDirectory ensures the file won't be included in a backup of the app.
        let fileManager = FileManager.default
        if let tmpDirURL = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            return tmpDirURL.appendingPathComponent(videoFilename).appendingPathExtension(videoFilenameExt)
        }
        fatalError("URLForDirectory() failed")
    }
}
