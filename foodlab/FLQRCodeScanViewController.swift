//
//  FLQRCodeScanViewController.swift
//  foodlab
//
//  Created by LiuMingchuan on 2017/9/24.
//  Copyright © 2017年 LiuMingchuan. All rights reserved.
//

import UIKit
import AVFoundation

class FLQRCodeScanViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var scanRectView:UIView!
    var device:AVCaptureDevice!
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
            self.input = try AVCaptureDeviceInput(device:device)
            
            self.output = AVCaptureMetadataOutput()
            self.output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.session = AVCaptureSession()
            if UIScreen.main.bounds.size.height < 500 {
                self.session.sessionPreset = AVCaptureSessionPreset640x480
            } else {
                self.session.sessionPreset = AVCaptureSessionPresetHigh
            }
            
            self.session.addInput(self.input)
            self.session.addOutput(self.output)
            
            self.output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            let windowSize = UIScreen.main.bounds.size
            let scanSize = CGSize(width: windowSize.width*3/4, height: windowSize.width*3/4)
            var scanRect = CGRect(x: (windowSize.width-scanSize.width)/2, y: (windowSize.height-scanSize.height)/2, width: scanSize.width, height: scanSize.height)
            
            scanRect = CGRect(x: scanRect.origin.y/windowSize.height, y: scanRect.origin.x/windowSize.width, width: scanRect.size.height/windowSize.height, height: scanRect.size.width/windowSize.width)
            
            self.output.rectOfInterest = scanRect
            
            self.preview = AVCaptureVideoPreviewLayer(session: self.session)
            
            self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            self.preview.frame = UIScreen.main.bounds
            
            self.view.layer.insertSublayer(self.preview, at: 0)
            
            self.scanRectView = UIView()
            self.view.addSubview(self.scanRectView)
            self.scanRectView.frame = CGRect(x: 0, y: 0, width: scanSize.width, height: scanSize.height)
            self.scanRectView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            self.scanRectView.layer.borderColor = UIColor.green.cgColor
            self.scanRectView.layer.borderWidth = 1
            
            self.session.startRunning()
            
        } catch _ {
            let alertController = UIAlertController(title: "提醒", message: "请在iPhone的\"设置-隐私-相机\"选项中，允许本程序访问您的相机", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (cancelAction) in
                self.navigationController!.popViewController(animated: true)
            })
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil {
                self.session.stopRunning()
            }
        }
        self.session.stopRunning()
        
        let alertController = UIAlertController(title: "二维码", message: stringValue, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.session.stopRunning()
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
