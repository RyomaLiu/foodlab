//
//  FLConstant.swift
//  foodlab
//
//  Created by LiuMingchuan on 2017/9/24.
//  Copyright © 2017年 LiuMingchuan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Alamofire


/// 语言文字本地化
///
/// - Parameter key: 键
/// - Returns: 本地化文字
func LocalString(_ key:String)->String{
    return NSLocalizedString(key, comment: "Not Found The String")
}
