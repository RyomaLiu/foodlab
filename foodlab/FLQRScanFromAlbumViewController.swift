//
//  FLQRScanFromAlbumViewController.swift
//  foodlab
//
//  Created by LiuMingchuan on 2017/9/24.
//  Copyright © 2017年 LiuMingchuan. All rights reserved.
//

import UIKit

class FLQRScanFromAlbumViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let btnScanQRCode:UIButton = UIButton(type: .roundedRect)
        
        btnScanQRCode.setTitle("从相册选取二维码", for: .normal)
        
        btnScanQRCode.sizeToFit()
        btnScanQRCode.center = CGPoint(x: self.view.center.x, y: 150)
        
        self.view.addSubview(btnScanQRCode)
        
        btnScanQRCode.addTarget(self, action:#selector(selectQRImgFromAlbum), for: .touchUpInside)

        
    }
    
    func selectQRImgFromAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let picker = UIImagePickerController()
            
            picker.delegate = self
            
            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: { 
                
            })
        } else {
            print("读取相册错误")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let ciImage:CIImage = CIImage(image: image)!
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        
        if let features = detector?.features(in: ciImage) {
            for feature in features as! [CIQRCodeFeature] {
                print(feature.messageString ?? "")
            }
        }
        
        picker.dismiss(animated: true) { 
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
