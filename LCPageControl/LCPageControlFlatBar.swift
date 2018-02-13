//
//  LCPageControlFlatBar.swift
//  LCPageControlExample
//
//  Created by Liu Chuan on 2018/2/1.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

/// 扁条视图
class LCPageControlFlatBar: UIView {

    
    /// 页码数
    var numberOfPage: Int = 0
    
    /// 当前页码
    var currentOfPage: Int = 0
    
    /// 开始标点
    var startPoint: CGFloat = 0.0
    
    var lastX: CGFloat = 0.0
    
    let imgMove = UIImageView()
    
    
    // MARK: - 系统方法
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - 自定义方法
    
    /// 配置扁条样式页码控制器视图
    ///
    /// - Parameters:
    ///   - page: 页码数
    ///   - current: 当前页码
    ///   - tintColor: 指示器颜色
    func configFlatBarStylePageView(_ page: Int, current: Int, tintColor: UIColor) {
        
        numberOfPage = page
        currentOfPage = current
        
        let allWidth: CGFloat = CGFloat(numberOfPage * 20)
        
        guard allWidth < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
   
        /// 图片视图的宽度
        let imageWidth: CGFloat = 15.0
        
        /// 图片视图的高度
        let imageHeight: CGFloat = 3.0
        
        /// 图片视图的X值
        var imageX: CGFloat = (self.frame.size.width - allWidth) / 2.0 - (imageWidth / 2.0)
        
        /// 图片视图的Y值
        let imageY: CGFloat = (self.frame.size.height - imageHeight) / 2.0
        
        var moveX: CGFloat = 0.0
        
        startPoint = imageX
        
        for i in 0 ..< numberOfPage {
            let imagePage = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight))
            imagePage.backgroundColor = tintColor
            imagePage.alpha = 0.2
            imagePage.layer.cornerRadius = imagePage.frame.size.height / 2
            imagePage.tag = i + 10
            addSubview(imagePage)
            if i == current {
                moveX = imagePage.frame.origin.x + 11
            }
            imageX += imageWidth + 5
        }
        
        lastX = moveX
        
        imgMove.frame = CGRect(x: moveX, y: imageY, width: imageWidth, height: imageHeight)
        imgMove.backgroundColor = tintColor
        imgMove.layer.cornerRadius = imgMove.frame.size.height / 2
        imgMove.tag = 5
        addSubview(imgMove)
    }
    
    
    
    /// 任何偏移量的变化
    ///
    /// - Parameter scrollView: 滚动视图
    func scrollVDid(_ scrollView: UIScrollView) {
        
        /// 滚动视图的宽度值
        let scrollWidth: CGFloat = scrollView.frame.size.width
        
        /// 横向水平移动的数值
        let horizontalMoveX: CGFloat = scrollView.contentOffset.x
        
        // 根据滚动视图的 宽度值 和 横向移动(x) 数值 计算当前页码
        let page = horizontalMoveX / scrollWidth
        
        let moveX: CGFloat = 20 * page
        imgMove.frame.origin.x = startPoint + moveX
        lastX = imgMove.frame.origin.x
    }
    
}
