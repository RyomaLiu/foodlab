//
//  UIImage+Category.swift
//  foodlab
//
//  Created by LiuMingchuan on 2017/9/24.
//  Copyright © 2017年 LiuMingchuan. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    class func imageWith(color:UIColor,size:CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let contextRef = UIGraphicsGetCurrentContext()
        contextRef?.setFillColor(color.cgColor)
        contextRef?.fill(rect)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
