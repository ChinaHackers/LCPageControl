//
//  LCPageControlFillCircle.swift
//  LCPageControlExample
//
//  Created by Liu Chuan on 2018/2/1.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

/// 填充圆视图
class LCPageControlFillCircle: UIView {

    /// 页码数
    var numberOfPage: Int = 0
    
    /// 当前页码
    var currentOfPage: Int = 0
    
    /// 开始标点
    var startPoint: CGFloat = 0.0
    
    //var start: CGFloat = 0.0
    
    var circle: CGFloat = 0.0
    
    
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
    /// 配置填充圆圈样式页码控制器视图
    ///
    /// - Parameters:
    ///   - page: 页码数
    ///   - current: 当前页码
    ///   - tintColor: 指示器颜色
    func configFillCircleStylePageView(_ page: Int, current: Int, tintColor: UIColor) {
        
        numberOfPage = page
        currentOfPage = current
        
        let allWidth: CGFloat = CGFloat(numberOfPage * 20)
        
        guard allWidth < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        circle = 10.0
        
        var x: CGFloat = (self.frame.size.width - allWidth) / 2.0 + 5
        let y: CGFloat = (self.frame.size.height - circle) / 2.0
        startPoint = x
        
        for i in 0 ..< numberOfPage {
            let pageView = UIImageView()
            pageView.layer.borderColor = tintColor.cgColor
            pageView.frame = CGRect(x: x, y: y, width: circle, height: circle)
            pageView.layer.cornerRadius = pageView.frame.size.height / 2
            pageView.tag = i + 10
            addSubview(pageView)
            if i == currentOfPage {
                pageView.layer.borderWidth = circle / 2
            }else {
                pageView.layer.borderWidth = 1
            }
            x += circle + 10
        }
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
        
        let tagValue = getImgViewTagNumber(page) + 10
        
        let nextStart: CGFloat = CGFloat(tagValue - 10) * scrollWidth
    
        let borderWidth = circle / 2 - 1.0
        
        let border: CGFloat = borderWidth * (horizontalMoveX - nextStart) / scrollWidth
        
        if let ivPage = self.viewWithTag(tagValue) as? UIImageView, tagValue >= 10 && tagValue + 1 < numberOfPage + 10 {
            
            ivPage.layer.borderWidth = circle / 2 - border
            
            if let pageNext = self.viewWithTag(tagValue + 1) as? UIImageView {
                pageNext.layer.borderWidth = 1 + border
            }
        }
    }
    
    
}
