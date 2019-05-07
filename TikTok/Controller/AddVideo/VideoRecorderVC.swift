//
//  ViewController.swift
//  RealTimeFilter
//
//  Created by ZhangAo on 14-9-20.
//  Copyright (c) 2014年 ZhangAo. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class VideoRecorderVC: UIViewController , AVCaptureVideoDataOutputSampleBufferDelegate , AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var switchCameraButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewFilterBtn: UIView!
    @IBOutlet weak var recordsButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewCapture: UIView!
    @IBOutlet weak var scrollFilter: UIScrollView!
    var process : String?
    var captureSession: AVCaptureSession!
    var previewLayer: CALayer!
    var filter: CIFilter!
    lazy var context: CIContext = {
        let eaglContext = EAGLContext(api: .openGLES2)
        let options = [kCIContextWorkingColorSpace : NSNull()]
        return CIContext(eaglContext: eaglContext!, options: options)
    }()
    
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
    
    lazy var filterNames: [String] = {
        return ["CIColorInvert", "CIPhotoEffectMono", "CIPhotoEffectInstant", "CIPhotoEffectTransfer"]
    }()
    var ciImage: CIImage!
    
    // 标记人脸
    // var faceLayer: CALayer?
    var faceObject: AVMetadataFaceObject?
    
    // Video Records
    var assetWriter: AVAssetWriter?
    var assetWriterPixelBufferInput: AVAssetWriterInputPixelBufferAdaptor?
    var isWriting = false
    var currentSampleTime: CMTime?
    var currentVideoDimensions: CMVideoDimensions?
    var currentDeviceInput: AVCaptureDeviceInput?
    var currentDevice: AVCaptureDevice?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewLayer = CALayer()
        
        previewLayer.anchorPoint = CGPoint.zero
        previewLayer.bounds = view.bounds
    
        self.view.layer.insertSublayer(previewLayer, at: 0)
        
        if TARGET_OS_SIMULATOR != 0 {
            let alert = UIAlertController(title: "提示", message: "不支持模拟器", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        } else {
            setupCaptureSession()
        }
        designFilter()
        self.prepareView()
        self.openCamera()
     
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        previewLayer.bounds.size = size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func designFilter(){
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
        
        scrollFilter.isHidden = true
    }
    
    @objc func filterButtonTapped(sender: UIButton) {
        
        filter = CIFilter(name: "\(CIFilterNames[sender.tag])" )
        
        scrollFilter.isHidden = true
    }
    
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        
        captureSession.sessionPreset = .high
        
        self.currentDevice = AVCaptureDevice.default(for: .video)
        let deviceInput = try! AVCaptureDeviceInput(device: self.currentDevice!)
        if captureSession.canAddInput(deviceInput) {
            captureSession.addInput(deviceInput)
            
            self.currentDeviceInput = deviceInput
        }
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        
        // 为了检测人脸
        let metadataOutput = AVCaptureMetadataOutput()
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            print(metadataOutput.availableMetadataObjectTypes)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.face]
        }
        
        captureSession.commitConfiguration()
    }
    
    func captureDevice(postion: AVCaptureDevice.Position = .front, anyDevice :Bool = true) -> AVCaptureDevice{
        let captureDevices = AVCaptureDevice.devices(for: .video)
        var device = captureDevices.first

        if anyDevice {
            return device!
        }
        
        for captureDevice in captureDevices {
            if captureDevice.position == postion{
                device = captureDevice
                break
            }
        }
        return device!;
    }
    func recordingStarted(){
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func captureImageAction(_ sender: UIButton) {
        recordsButton.setImage(UIImage.init(named: "capture"), for: .normal)
        process = "capture"

        self.viewCapture.backgroundColor = UIColor.clear
        
        //  openCamera()
    }
    @IBAction func recordVideoAction(_ sender: UIButton) {
        recordsButton.setImage(UIImage.init(named: "recording"), for: .normal)
        process = "recording"
        self.viewCapture.backgroundColor = UIColor.clear
      //  openCamera()
    }
    func prepareView(){
        if process != "recording"{
            recordsButton.setImage(UIImage.init(named: "capture"), for: .normal)

        }else{
            recordsButton.setImage(UIImage.init(named: "recording"), for: .normal)

        }
    }
    
    @IBAction func FilterAction(_ sender: UIButton) {
        
        scrollFilter.isHidden = false
        
    }
    // Switch camera front or back
   
    @IBAction func switchCameraAction(_ sender: UIButton) {
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
        faceObject = nil
    }
    
    func openCamera() {
        captureSession.startRunning()
        
   //     let captureDevices = AVCaptureDevice.devices(for: .video)
     //   switchCameraButton.isHidden = captureDevices.count < 1
    }
    
   
    
    func takePicture() {
        if ciImage == nil || isWriting {
            return
        }
        recordsButton.isEnabled = false
        captureSession.stopRunning()

        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        ALAssetsLibrary().writeImage(toSavedPhotosAlbum: cgImage, metadata: ciImage.properties) { (url, error) in
            if error == nil {
                print("success")
                print(url!)
            } else {
                let alert = UIAlertController(title: "failed", message: error?.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            self.captureSession.startRunning()
            self.recordsButton.isEnabled = true
        }
    }
    
    // MARK: - Video Records
    
    @IBAction func recordAction(_ sender: UIButton) {
        if process != "capture" {
            //start video recording
            record()
        }else{
            // capture image
            takePicture()
        }
    }
    func record() {
        if self.isWriting {
            self.isWriting = false
            self.assetWriterPixelBufferInput = nil
         //   self.recordsButton.isEnabled = false
            self.assetWriter?.finishWriting(completionHandler: {[unowned self] () -> Void in
                DispatchQueue.main.async {
                    print("start recording")
                    UIView.animate(withDuration: 0.1, animations: {
                        self.recordsButton.frame.size = CGSize(width: 50, height:50)
                        self.viewCapture.layoutIfNeeded()
                    })
                    
                   // self.recordsButton.setTitle("recording...", for: .normal)
                }
                
                self.saveMovieToCameraRoll() {
                    DispatchQueue.main.async {
                   //     self.recordsButton.isEnabled = true
                    //    self.recordsButton.setTitle("Record", for: .normal)
                    //    self.switchCameraButton.isEnabled = true
                    }
                }
            })
        } else {
            self.createWriter()
          //  self.recordsButton.setTitle("recording...", for: .normal)
            self.assetWriter?.startWriting()
            self.assetWriter?.startSession(atSourceTime: self.currentSampleTime!)
            self.isWriting = true
          //  self.switchCameraButton.isEnabled = false
        }
    }
    
    func saveMovieToCameraRoll(_ finishBlock: @escaping () -> Void) {
        ALAssetsLibrary().writeVideoAtPath(toSavedPhotosAlbum: movieURL() as URL!) { (url, error) in
            if let errorDescription = error?.localizedDescription {
                print("写入视频错误：\(errorDescription)")
            } else {
                print(url?.absoluteString)
                self.checkForAndDeleteFile()
                let board = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = board.instantiateViewController(withIdentifier: "videoeditor") as! VideoEditorVC
                vc.videoPath = url?.absoluteString
                self.navigationController?.pushViewController(vc, animated: true)
                print("写入视频成功")
            }
            
            finishBlock()
        }
    }
    
    func movieURL() -> NSURL {
        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let myurl = docsurl.appendingPathComponent("tmpMov.mov")
        
        let tempDir = NSTemporaryDirectory()
        let url = NSURL(fileURLWithPath: tempDir).appendingPathComponent("tmpMov.mov")
        return myurl as NSURL
    }
    
    func checkForAndDeleteFile() {
        let fm = FileManager.default
        let url = movieURL()
        let exist = fm.fileExists(atPath: url.path!)
        
        if exist {
            print("exits")
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
            assetWriter = try AVAssetWriter(outputURL: movieURL() as URL, fileType: AVFileType.mov)
        } catch let error as NSError {
            print("创建writer失败")
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
        assetWriterVideoInput.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
        
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
            print("不能添加视频writer的input \(assetWriterVideoInput)")
        }
        
        // add audio input
        let audioWriterInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: nil)
        
        audioWriterInput.expectsMediaDataInRealTime = true
        
        if (assetWriter?.canAdd(audioWriterInput))! {
            assetWriter?.add(audioWriterInput)
            print("audio input added")
        }
    }
    
    func makeFaceWithCIImage(inputImage: CIImage, faceObject: AVMetadataFaceObject) -> CIImage {
        let filter = CIFilter(name: "CIPixellate")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        // 1.
        filter.setValue(max(inputImage.extent.size.width, inputImage.extent.size.height) / 60, forKey: kCIInputScaleKey)
        
        let fullPixellatedImage = filter.outputImage

        var maskImage: CIImage!
        let faceBounds = faceObject.bounds
        
        // 2.
        let centerX = inputImage.extent.size.width * (faceBounds.origin.x + faceBounds.size.width / 2)
        let centerY = inputImage.extent.size.height * (1 - faceBounds.origin.y - faceBounds.size.height / 2)
        let radius = faceBounds.size.width * inputImage.extent.size.width / 2
        let radialGradient = CIFilter(name: "CIRadialGradient",
            withInputParameters: [
                "inputRadius0" : radius,
                "inputRadius1" : radius + 1,
                "inputColor0" : CIColor(red: 0, green: 1, blue: 0, alpha: 1),
                "inputColor1" : CIColor(red: 0, green: 0, blue: 0, alpha: 0),
                kCIInputCenterKey : CIVector(x: centerX, y: centerY)
            ])!

        let radialGradientOutputImage = radialGradient.outputImage!.cropped(to: inputImage.extent)
        if maskImage == nil {
            maskImage = radialGradientOutputImage
        } else {
            print(radialGradientOutputImage)
            maskImage = CIFilter(name: "CISourceOverCompositing",
                withInputParameters: [
                    kCIInputImageKey : radialGradientOutputImage,
                    kCIInputBackgroundImageKey : maskImage
                ])!.outputImage
        }
        
        let blendFilter = CIFilter(name: "CIBlendWithMask")!
        blendFilter.setValue(fullPixellatedImage, forKey: kCIInputImageKey)
        blendFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
        blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
        
        return blendFilter.outputImage!
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        autoreleasepool {
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
            
            let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)!
            self.currentVideoDimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
            self.currentSampleTime = CMSampleBufferGetOutputPresentationTimeStamp(sampleBuffer)
            
            // CVPixelBufferLockBaseAddress(imageBuffer, 0)
            // let width = CVPixelBufferGetWidthOfPlane(imageBuffer, 0)
            // let height = CVPixelBufferGetHeightOfPlane(imageBuffer, 0)
            // let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0)
            // let lumaBuffer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
            //
            // let grayColorSpace = CGColorSpaceCreateDeviceGray()
            // let context = CGBitmapContextCreate(lumaBuffer, width, height, 8, bytesPerRow, grayColorSpace, CGBitmapInfo.allZeros)
            // let cgImage = CGBitmapContextCreateImage(context)
            var outputImage = CIImage(cvImageBuffer: imageBuffer)
            
            if self.filter != nil {
                self.filter.setValue(outputImage, forKey: kCIInputImageKey)
                outputImage = self.filter.outputImage!
            }
          /*  if self.faceObject != nil {
                outputImage = self.makeFaceWithCIImage(inputImage: outputImage, faceObject: self.faceObject!)
            }
 */
            
            // 录制视频的处理
            if self.isWriting {
                if self.assetWriterPixelBufferInput?.assetWriterInput.isReadyForMoreMediaData == true {
                    var newPixelBuffer: CVPixelBuffer? = nil
                    
                    CVPixelBufferPoolCreatePixelBuffer(nil, self.assetWriterPixelBufferInput!.pixelBufferPool!, &newPixelBuffer)
                    
                    self.context.render(outputImage, to: newPixelBuffer!, bounds: outputImage.extent, colorSpace: nil)
                    
                    let success = self.assetWriterPixelBufferInput?.append(newPixelBuffer!, withPresentationTime: self.currentSampleTime!)
                    
                    if success == false {
                        print("Pixel Buffer没有附加成功")
                    }
                }
            }
            
            let orientation = UIDevice.current.orientation
            var t: CGAffineTransform!
            if orientation == UIDeviceOrientation.portrait {
                t = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
            } else if orientation == UIDeviceOrientation.portraitUpsideDown {
                t = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
            } else if (orientation == UIDeviceOrientation.landscapeRight) {
                t = CGAffineTransform(rotationAngle: CGFloat.pi)
            } else {
                t = CGAffineTransform(rotationAngle: 0)
            }
            outputImage = outputImage.transformed(by: t)
            
            let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent)
            self.ciImage = outputImage
            
            DispatchQueue.main.async {
                self.previewLayer.contents = cgImage
            }
        }
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // print(metadataObjects)
        if metadataObjects.count > 0 {
            //识别到的第一张脸
            faceObject = metadataObjects.first as? AVMetadataFaceObject
            
            /*
            if faceLayer == nil {
                faceLayer = CALayer()
                faceLayer?.borderColor = UIColor.redColor().CGColor
                faceLayer?.borderWidth = 1
                view.layer.addSublayer(faceLayer)
            }
            let faceBounds = faceObject.bounds
            let viewSize = view.bounds.size
    
            faceLayer?.position = CGPoint(x: viewSize.width * (1 - faceBounds.origin.y - faceBounds.size.height / 2),
                                          y: viewSize.height * (faceBounds.origin.x + faceBounds.size.width / 2))
            
            faceLayer?.bounds.size = CGSize(width: faceBounds.size.height * viewSize.width,
                                            height: faceBounds.size.width * viewSize.height)
            print(faceBounds.origin)
            print("###")
            print(faceLayer!.position)
            print("###")
            print(faceLayer!.bounds)
            */
        }else{
            faceObject = nil
        }
    }
}

