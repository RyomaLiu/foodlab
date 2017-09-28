//
//  LMCPopoverMenuView.swift
//  foodlab
//
//  Created by LiuMingchuan on 2017/9/24.
//  Copyright © 2017年 LiuMingchuan. All rights reserved.
//

import UIKit


class LMCPopoverMenuView: UIView,UITableViewDelegate,UITableViewDataSource {

    //菜单列表
    private var menuTab:UITableView?
    //菜单项目
    private var menuArr:Array<Any>?
    //列表行识别符
    private let cellIdentifier = "CellID"
    //菜单是否显示
    var isShow:Bool?
    //菜单尺寸
    var menuSize:CGSize?
    
    var didSelectIndex:((_ index:Int) -> Void)?
    
    class func initMenu(size:CGSize) -> LMCPopoverMenuView {
        
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let menu = LMCPopoverMenuView.init(frame: frame)
        menu.menuSize = size
        return menu
    }
    
    override init(frame: CGRect) {
        let initFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 0)
        
        super.init(frame: initFrame)
        self.backgroundColor = UIColor.black
        
        menuTab = UITableView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), style: .plain)
        menuTab?.tableFooterView = UIView()
        menuTab?.delegate = self
        menuTab?.dataSource = self
        
        
        
        addSubview(menuTab!)
        
        menuTab?.isHidden = true
        isHidden = true
        isShow = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func popMenu(originPoint:CGPoint,arr:Array<Any>) {
        if self.isShow == true {
            return
        }
        self.isShow = true
        self.isHidden = false
        self.menuTab?.isHidden = false
        
        self.frame.origin = CGPoint(x: originPoint.x - (self.menuSize?.width)!, y: originPoint.y)
        self.menuArr = arr
        self.menuTab?.reloadData()
        
        self.superview?.bringSubview(toFront: self)
        menuTab?.frame.size.height = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.size.height = self.menuSize!.height
            self.menuTab?.frame.size.height = self.menuSize!.height
        }) { (finish) in
            
        }
    }
    
    /// 收起菜单
    func packUpMenu() {
        if self.isShow == false {
            return
        }
        
        self.isShow = false
        
        //收起动画
        UIView.animate(withDuration: 0.3, animations: {
            self.menuTab?.frame.size.height = 0
            self.frame.size.height = 0
        }) { (finish) in
            self.isHidden = true
            self.menuTab?.isHidden = true
        }
    }
    
    
    /// 章节行数
    ///
    /// - Parameters:
    ///   - tableView: 列表视图
    ///   - section: 章节
    /// - Returns: 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuArr?.count != nil {
            return (menuArr?.count)!
        }
        return 0
    }
    
    
    /// 列表行视图
    ///
    /// - Parameters:
    ///   - tableView: 列表视图
    ///   - indexPath: 索引路径
    /// - Returns: 行视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell?.textLabel?.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell?.textLabel?.text = menuArr?[indexPath.row] as? String
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 11.0)
        
        return cell!
    }
    
    
    /// 列表行高度
    ///
    /// - Parameters:
    ///   - tableView: 列表视图
    ///   - indexPath: 索引路径
    /// - Returns: 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    
    /// 列表选择
    ///
    /// - Parameters:
    ///   - tableView: 列表视图
    ///   - indexPath: 索引路径
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.didSelectIndex != nil {
            self.didSelectIndex!(indexPath.row)
        }
        
        self.packUpMenu()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
