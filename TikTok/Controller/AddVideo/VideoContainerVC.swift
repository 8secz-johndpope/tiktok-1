//
//  VideoConatinerVC.swift
//  TikTok
//
//  Created by vishal singh on 19/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import CoreMedia
import Photos



class VideoConatinerVC: Default , AVCaptureVideoDataOutputSampleBufferDelegate {

    var CIFilterNames = ["CIColorClamp",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone",
        "CIVibrance"
    ]
    var FilterNames = ["Default",
                       "Chrome",
                       "Fade",
                       "Instant",
                       "Noir",
                       "Process",
                       "Tonal",
                       "Transfer",
                       "SepiaTone",
                       "Vibrance"
    ]
    var filter = CIFilter(name: "CIColorClamp" )
    var captureSession: AVCaptureSession!
    

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewFilterBtn: UIView!
    @IBOutlet weak var recordButtton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewOption: UIView!
    @IBOutlet weak var viewCapture: UIView!
    @IBOutlet weak var scrollFilter: UIScrollView!
    
    var assetWriter: AVAssetWriter?
    var assetWriterPixelBufferInput: AVAssetWriterInputPixelBufferAdaptor?
    var isWriting = false
    var currentSampleTime: CMTime?
    var currentVideoDimensions: CMVideoDimensions?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        scrollFilter.isHidden = true

        viewOption.backgroundColor = UIColor.clear
        viewCapture.isHidden = true
        
        // filter design
        var xCoord: CGFloat = 10
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 60
        let buttonHeight: CGFloat = 60
        let gapBetweenButtons: CGFloat = 10
        
        var itemCount = 0
        
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(self.filterButtonTapped(sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 30
            filterButton.clipsToBounds = true
            
            // label properties
            let filterLabel = UILabel()
            filterLabel.frame = CGRect(x: xCoord, y: 65, width: buttonWidth, height: 20)
            filterLabel.text = FilterNames[i]
            filterLabel.textAlignment = .center
            filterLabel.font = UIFont.systemFont(ofSize: 12)
            filterLabel.textColor = UIColor.white
            filterLabel.backgroundColor = UIColor.clear
            
            
            // CODE FOR FILTERS WILL BE ADDED HERE...
            
            // Create filters for each button
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: UIImage.init(named: "dummyimg")!)
            
            
            
            // Assign filtered image to the button
            if i == 0 {
                filterButton.setBackgroundImage(UIImage.init(named: "dummyimg"), for: .normal)

            }else{
                let filter = CIFilter(name: "\(CIFilterNames[i])" )
                filter!.setDefaults()
                filter!.setValue(coreImage, forKey: kCIInputImageKey)
                
                let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
                let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
                let imageForButton = UIImage.init(cgImage: filteredImageRef!)
                
                filterButton.setBackgroundImage(imageForButton, for: .normal)

            }
        //    filterButton.setBackgroundImage(imageForButton, forState: .normal)
            
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            scrollFilter.addSubview(filterButton)
            scrollFilter.addSubview(filterLabel)
        } // END FOR LOOP
        
        
        // Resize Scroll View
        scrollFilter.contentSize = CGSize(width: CGFloat((buttonWidth + 10) * CGFloat(CIFilterNames.count)) + 10, height: yCoord)
            
    }
    
    @objc func filterButtonTapped(sender: UIButton) {
        
        //imageView.image = sender.backgroundImage(for: UIControlState.normal)
        filter = CIFilter(name: "\(CIFilterNames[sender.tag])" )

        
        scrollFilter.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video), let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            print("Can't access the camera")
            return
        }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        let audioOutput = AVCaptureAudioDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        if captureSession.canAddOutput(audioOutput) {
            captureSession.addOutput(audioOutput)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.bounds = view.bounds
        previewLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      //  if((previewLayer) != nil) {
            previewView.layer.addSublayer(previewLayer)
      //  }
        
        captureSession.startRunning()
    }
    @IBAction func closeAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func recordVideoAction(_ sender: UIButton) {
        viewCapture.isHidden = false
        self.viewCapture.backgroundColor = UIColor.clear
        viewOption.removeFromSuperview()
    }
    @IBAction func FilterAction(_ sender: UIButton) {

   /*     if i < fArr.count{
            self.filter = fArr[i + 1]
            i = i + 1
        }else{
            self.view.makeToast("limited filter avail")
        }
     */
        scrollFilter.isHidden = false
        
    }
    
    @IBAction func record(_ sender: Any) {
        if isWriting {
            print("stop record")
            self.isWriting = false
            assetWriterPixelBufferInput = nil
            assetWriter?.finishWriting(completionHandler: {[unowned self] () -> Void in
                self.saveMovieToCameraRoll()
            })
        } else {
            print("start record")
            createWriter()
            assetWriter?.startWriting()
            assetWriter?.startSession(atSourceTime: currentSampleTime!)
            isWriting = true
        }
    }
    
    func saveMovieToCameraRoll() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.movieURL() as URL)
        }) { saved, error in
            if saved {
                print("saved")
            }
        }
    }
    
    func movieURL() -> NSURL {
        let tempDir = NSTemporaryDirectory()
        let url = NSURL(fileURLWithPath: tempDir).appendingPathComponent("tmpMov.mov")
        return url! as NSURL
    }
    
    func checkForAndDeleteFile() {
        let fm = FileManager.default
        let url = movieURL()
        let exist = fm.fileExists(atPath: url.path!)
        
        if exist {
            do {
                try fm.removeItem(at: url as URL)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func createWriter() {
        self.checkForAndDeleteFile()
        
        do {
            assetWriter = try AVAssetWriter(outputURL: movieURL() as URL, fileType: AVFileType.mov)//AVFileTypeQuickTimeMovie
        } catch let error as NSError {
            print(error.localizedDescription)
            return
        }
       
        let outputSettings = [
            AVVideoCodecKey : AVVideoCodecH264,
            AVVideoWidthKey : Int(currentVideoDimensions!.width),
            AVVideoHeightKey : Int(currentVideoDimensions!.height)
            ] as [String : Any]
        
        let assetWriterVideoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: outputSettings)
        assetWriterVideoInput.expectsMediaDataInRealTime = true
        //assetWriterVideoInput.transform = CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0))
        
        let sourcePixelBufferAttributesDictionary = [
            String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_32BGRA),
            String(kCVPixelBufferWidthKey) : Int(currentVideoDimensions!.width),
            String(kCVPixelBufferHeightKey) : Int(currentVideoDimensions!.height),
            String(kCVPixelFormatOpenGLESCompatibility) : kCFBooleanTrue
            ] as [String : Any]
        
        assetWriterPixelBufferInput = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: assetWriterVideoInput,
                                                                           sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)
        
        if assetWriter!.canAdd(assetWriterVideoInput) {
            assetWriter!.add(assetWriterVideoInput)
        } else {
            print("no way\(assetWriterVideoInput)")
        }
    }
    
   
    
     func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
       // autoreleasepool {
            
        
        connection.videoOrientation = AVCaptureVideoOrientation.portrait;
      
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let cameraImage = CIImage(cvPixelBuffer: pixelBuffer)
        
 

        filter?.setValue(cameraImage, forKey: kCIInputImageKey)
            
            
            let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)!
            self.currentVideoDimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
            self.currentSampleTime = CMSampleBufferGetOutputPresentationTimeStamp(sampleBuffer)
            
        
        
        
        if self.isWriting {
            if self.assetWriterPixelBufferInput?.assetWriterInput.isReadyForMoreMediaData == true {
                // COMMENT: Here's where it gets weird. You've declared a new, empty pixelBuffer... but you already have one (pixelBuffer) that contains the image you want to write...
                var newPixelBuffer: CVPixelBuffer? = nil
                
                // COMMENT: And you grabbed memory from the pool.
                CVPixelBufferPoolCreatePixelBuffer(nil, self.assetWriterPixelBufferInput!.pixelBufferPool!, &newPixelBuffer)
                DispatchQueue.init(label: "record filtered video")
                if let outputValue = self.filter?.value(forKey: kCIOutputImageKey) as? CIImage {
                    let filteredImage = UIImage(ciImage: outputValue)
                    newPixelBuffer = buffer(from: filteredImage)
                    
                    // COMMENT: And now you wrote an empty pixelBuffer back <-- this is what's causing the black frame.
                    let success = self.assetWriterPixelBufferInput?.append(newPixelBuffer!, withPresentationTime: self.currentSampleTime!)
                    
                    if success == false {
                        print("Pixel Buffer failed")
                    }
                    
                }
                
                
            }
        }
        
            
            DispatchQueue.main.async {
                
                if let outputValue = self.filter?.value(forKey: kCIOutputImageKey) as? CIImage {
                    let filteredImage = UIImage(ciImage: outputValue)
                    self.imageView.image = filteredImage
                    self.imageView.contentMode = UIViewContentMode.scaleAspectFill
                }
            }
 
    }
    
    func buffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    func convert(cmage:CIImage) -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
   /* @IBAction func clickSwitchCameraButton(sender: UIButton){
        guard let currentDeviceInput = self.currentDeviceInput else { return }
        
        captureSession.removeInput(currentDeviceInput)
        switch currentDevice!.position {
        case .back:
            currentDevice = captureDevice(postion: .front, anyDevice: false)
        case .front:
            currentDevice = captureDevice(postion: .back, anyDevice: false)
        case .unspecified:
            assert(false)
        }
        let input = try! AVCaptureDeviceInput(device: self.currentDevice!)
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
            
            self.currentDeviceInput = input
        }
        
        let animation = CATransition()
        animation.duration = 0.25
        animation.subtype = kCATruncationMiddle
        animation.type = kCATransitionFade
        self.view.layer.add(animation, forKey: nil)
    }
 */
}
