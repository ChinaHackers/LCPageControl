//
//  LCPageControlNormal.swift
//  LCPageControlExample
//
//  Created by Liu Chuan on 2018/2/1.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

/// 默认视图
class LCPageControlNormal: UIView {
    
    /// 页码数
    var numberOfPage: Int = 0
    
    /// 当前页码
    var currentOfPage: Int = 0
    
    /// 开始标点
    var startPoint: CGFloat = 0.0
    
    /// 起点
    var start: CGFloat = 0.0
   
    // MARK: - 系统方法
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    // MARK: - 自定义方法
    
    /// 配置默认样式页码控制器视图
    ///
    /// - Parameters:
    ///   - page: 页码数
    ///   - current: 当前页码
    ///   - tintColor: 指示器颜色
    func configNormalStylePageView(_ page: Int, current: Int, tintColor: UIColor) {
        
        numberOfPage = page
        currentOfPage = current
        
        let allWidth: CGFloat = CGFloat((numberOfPage - 1) * 20 + 25)
        
        guard allWidth < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        /// 图片视图的宽度
        var imageWidth: CGFloat = 10.0
       
        /// 图片视图的高度
        let imageHeight: CGFloat = 10.0
        
        /// 图片视图的X值
        var imageX: CGFloat = (self.frame.size.width - allWidth) / 2.0
        
        /// 图片视图的Y值
        let imageY: CGFloat = (self.frame.size.height - imageHeight) / 2.0
        
        startPoint = imageX
        
        // 遍历页码数, 创建图片
        for i in 0 ..< numberOfPage {
            
            let imgPage = UIImageView()
            
            if i == currentOfPage { // 如果处于当前页码,设置图片的宽度,透明度
                imageWidth = 25.0
                imgPage.alpha = 1.0
            } else {
                imageWidth = 10.0
                imgPage.alpha = 0.4
            }
            // 设置图片视图相关属性
            imgPage.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
            imgPage.layer.cornerRadius = imgPage.frame.size.height / 2.0 //圆角裁切
            imgPage.backgroundColor = tintColor
            imgPage.tag = i + 10
            self.addSubview(imgPage)
            imageX += imageWidth + 10
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
        
        /// tag数值
        let tagValue = getImgViewTagNumber(page) + 10
        
        /// 下一个起点
        let nextStart: CGFloat = CGFloat(tagValue - 10) * scrollWidth
        
        /// 移动数值
        let move: CGFloat = 15 * (startPoint - horizontalMoveX) / scrollWidth
        
        /// 透明度
        let Alpha: CGFloat = 0.6 * (horizontalMoveX - nextStart) / scrollWidth

//        guard let ivPage = self.viewWithTag(tagValue) as? UIImageView else { return }
//        guard tagValue >= 10 && tagValue + 1 < 10 + numberOfPage else { return }
        
  
        if let ivPage = self.viewWithTag(tagValue) as? UIImageView, tagValue >= 10 && tagValue + 1 < 10 + numberOfPage {
            
            let x = startPoint + (CGFloat(tagValue) - 10) * 20
            let y = ivPage.frame.origin.y
            let w = 25 + (move + (CGFloat(tagValue) - 10) * 15)
            let h = ivPage.frame.size.height
            
            ivPage.frame = CGRect(x: x, y: y, width: w, height: h)
            ivPage.alpha = 1 - Alpha
            
            if let ivPageNext = self.viewWithTag(tagValue + 1) as? UIImageView {
                let pageNextX: CGFloat = (startPoint + 35) + (CGFloat(tagValue) - 10) * 20
                let nextX = pageNextX + (move + ((CGFloat(tagValue) - 10) * 15))
                let nextY = ivPageNext.frame.origin.y
                let nextW = 10 - (move + (CGFloat(tagValue) - 10) * 15)
                let nextH = ivPageNext.frame.size.height
                
                ivPageNext.frame = CGRect(x: nextX, y: nextY, width: nextW, height: nextH)
                ivPageNext.alpha = 0.4 + Alpha
            }
            
            
            
        }
        
/*
        let x = startPoint + (CGFloat(tagValue) - 10) * 20
        let y = ivPage.frame.origin.y
        let w = 25 + (move + (CGFloat(tagValue) - 10) * 15)
        let h = ivPage.frame.size.height
        
        ivPage.frame = CGRect(x: x, y: y, width: w, height: h)
        ivPage.alpha = 1 - Alpha
        
        guard let ivPageNext = self.viewWithTag(tagValue + 1) as? UIImageView else { return }
//        guard let pageNextX: CGFloat = (startPoint + 35) + (CGFloat(tagValue) - 10) * 20 else { return }

        let pageNextX: CGFloat = (startPoint + 35) + (CGFloat(tagValue) - 10) * 20
        let nextX = pageNextX + (move + ((CGFloat(tagValue) - 10) * 15))
        let nextY = ivPageNext.frame.origin.y
        let nextW = 10 - (move + (CGFloat(tagValue) - 10) * 15)
        let nextH = ivPageNext.frame.size.height
        
        ivPageNext.frame = CGRect(x: nextX, y: nextY, width: nextW, height: nextH)
        ivPageNext.alpha = 0.4 + Alpha
*/
    }
}
