//
//  FLMainViewController.swift
//  foodlab
//
//  Created by LiuMingchuan on 2017/9/24.
//  Copyright © 2017年 LiuMingchuan. All rights reserved.
//

import UIKit

class FLMainViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var menu:LMCPopoverMenuView?
    var menuItems:Array<Any>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //主页面标题
        self.title = LocalString("app_main_title")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWith(color: UIColor.init(red: 246.0/255, green: 247.0/255, blue: 249.0/255, alpha: 1.0), size: CGSize(width: 1, height: 1)), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //右上角菜单
        let menuBtn:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_right"), style: .plain, target: self, action: #selector(openMenu))
        menuBtn.imageInsets = UIEdgeInsetsMake(5, 2, 5, 2)
        self.navigationItem.rightBarButtonItem = menuBtn
        
        
        self.view.backgroundColor = UIColor.white
        
        let btnScanQRCode:UIButton = UIButton(type: .roundedRect)
        
        btnScanQRCode.setTitle("二维码扫描", for: .normal)
        
        btnScanQRCode.sizeToFit()
        btnScanQRCode.center = CGPoint(x: self.view.center.x, y: 150)
        
        self.view.addSubview(btnScanQRCode)
        
        btnScanQRCode.addTarget(self, action:#selector(openQRScan), for: .touchUpInside)
        
        let btnScanQRCodeFromAlbum:UIButton = UIButton(type: .roundedRect)
        
        btnScanQRCodeFromAlbum.setTitle("相册选取二维码扫描", for: .normal)
        
        btnScanQRCodeFromAlbum.sizeToFit()
        btnScanQRCodeFromAlbum.center = CGPoint(x: self.view.center.x, y: 200)
        
        self.view.addSubview(btnScanQRCodeFromAlbum)
        
        btnScanQRCodeFromAlbum.addTarget(self, action:#selector(openQRScanFromAlbum), for: .touchUpInside)
        
        let btnCallCamera:UIButton = UIButton(type: .roundedRect)
        
        btnCallCamera.setTitle("启动相机", for: .normal)
        
        btnCallCamera.sizeToFit()
        btnCallCamera.center = CGPoint(x: self.view.center.x, y: 250)
        
        self.view.addSubview(btnCallCamera)
        
        btnCallCamera.addTarget(self, action:#selector(openCamera), for: .touchUpInside)
        
        menu = LMCPopoverMenuView.initMenu(size: CGSize(width: 100, height: 350))
        
        self.navigationController?.navigationBar .addSubview(menu!)
        menuItems = ["扫描二维码","生成二维码"]
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func openMenu(sender:UIBarButtonItem){
        let view = sender.value(forKey: "view") as? UIView
        let center = view?.center
        
        print(center!)
        
        if self.menu?.isShow == false {
            self.menu?.popMenu(originPoint: center!, arr: self.menuItems)
            self.menu?.didSelectIndex = { (index:Int) in
                if index == 0 {
                    print(self.menuItems[0])
                } else {
                    print(self.menuItems[1])
                }
            }
        } else {
            self.menu?.packUpMenu()
        }
    }
    
    func openQRScan() {
        let qrcodeViewController:FLQRCodeScanViewController = FLQRCodeScanViewController()
        self.navigationController?.pushViewController(qrcodeViewController, animated: true)
    }
    
    func openQRScanFromAlbum() {
        let qrcodeFromAlbumViewController:FLQRScanFromAlbumViewController = FLQRScanFromAlbumViewController()
        self.navigationController?.pushViewController(qrcodeFromAlbumViewController, animated: true)
    }
    
    var imagePickerViewController:UIImagePickerController!
    func openCamera() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = false
        
        imagePickerViewController.sourceType = .camera
        
        let screenSize = UIScreen.main.bounds.size
        let cameraAspectRatio:CGFloat = 4.0 / 3.0
        let imageWidth:CGFloat = CGFloat(floorf(Float(screenSize.width * cameraAspectRatio)))
        let scale:CGFloat = CGFloat(ceilf(Float((screenSize.height / imageWidth) * 10.0)) / 10.0)
        
        imagePickerViewController.cameraViewTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        imagePickerViewController.showsCameraControls = false
        
        let overlay = UIView(frame: UIScreen.main.bounds)
        overlay.backgroundColor = UIColor.clear
        
        let btnTake:UIButton = UIButton(type: .roundedRect)
        btnTake.imageEdgeInsets = UIEdgeInsets.zero
        btnTake.frame.size = CGSize(width: 50, height: 50)
        btnTake.setBackgroundImage(UIImage(named: "photograph"), for: .normal)
        btnTake.setBackgroundImage(UIImage(named: "photograph_Select"), for: .highlighted)
        
        btnTake.center = CGPoint(x: overlay.center.x, y: overlay.frame.size.height-30)
        overlay.addSubview(btnTake)
        
        btnTake.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        
        let btnFrontRear:UIButton = UIButton(type: .roundedRect)
        btnFrontRear.imageEdgeInsets = UIEdgeInsets.zero
        btnFrontRear.frame.size = CGSize(width: 32, height: 24)
        btnFrontRear.setBackgroundImage(UIImage(named: "fromt_rear"), for: .normal)
        
        btnFrontRear.center = CGPoint(x: 40, y: 32)
        overlay.addSubview(btnFrontRear)
        
        btnFrontRear.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
        
        let btnCancel:UIButton = UIButton(type: .roundedRect)
        btnCancel.setTitle("取消", for: .normal)
        btnCancel.sizeToFit()
        
        btnCancel.center = CGPoint(x: 40, y: btnTake.center.y)
        overlay.addSubview(btnCancel)

        
        btnCancel.addTarget(self, action: #selector(closeCamera), for: .touchUpInside)
        
        self.imagePickerViewController.cameraOverlayView = overlay

        
        NotificationCenter.default.addObserver(forName: Notification.Name("_UIImagePickerControllerUserDidCaptureItem"), object: nil, queue: nil) { (para) in
            self.imagePickerViewController.cameraOverlayView = overlay
        }
        
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    func takePhoto() {
        self.imagePickerViewController.takePicture()
    }
    func changeCamera() {
        if imagePickerViewController.cameraDevice == .front {
            imagePickerViewController.cameraDevice = .rear
        } else {
            imagePickerViewController.cameraDevice = .front
        }
    }
    
    func closeCamera() {
        imagePickerViewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let imgView:UIImageView = UIImageView()
        imgView.frame.size = CGSize(width: 100, height: 100)
        imgView.center = CGPoint(x: self.view.center.x, y: 70)
        imgView.contentMode = .scaleAspectFill
        imgView.image = img
        self.view.addSubview(imgView)
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.menu?.isShow == true {
            self.menu?.packUpMenu()
        }
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
