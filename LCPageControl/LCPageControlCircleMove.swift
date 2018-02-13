//
//  LCPageControlCircleMove.swift
//  LCPageControlExample
//
//  Created by Liu Chuan on 2018/2/1.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

/// 圆移动视图
class LCPageControlCircleMove: UIView {

    
    let vi = UIView()
    
    /// 圆圈聚焦图片
    let imgFocus = UIImageView()
    
    /// 圆圈大小
    let circleSize: CGFloat = 17
    
    /// 页码数
    var numberOfPage: Int = 0

    /// 当前页码
    var currentOfPage: Int = 0
    
    /// 开始标点
    var startPoint: CGFloat = 0.0
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
    
    /// 配置圆圈移动样式页码控制器视图
    ///
    /// - Parameters:
    ///   - page: 页码数
    ///   - current: 当前页码
    ///   - tintColor: 指示器颜色
    func configCircleMoveStylePageView(_ page: Int, current: Int, tintColor: UIColor) {
        
        numberOfPage = page
        currentOfPage = current
        
        let allWidth: CGFloat = CGFloat(numberOfPage * 20)
        
        guard allWidth < self.frame.size.width else {
            print("frame.Width over Number Of Page")
            return
        }
        
        imgFocus.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
        imgFocus.center = self.center
        imgFocus.layer.cornerRadius = imgFocus.frame.size.height / 2.0
        imgFocus.layer.borderColor = tintColor.cgColor
        imgFocus.layer.borderWidth = 1.0
        imgFocus.backgroundColor = .clear
        addSubview(imgFocus)
        
        /// 图片视图的宽度
        let imageWidth: CGFloat = 10.0
        
        /// 图片视图的高度
        let imageHeight: CGFloat = 10.0
        
        /// 图片视图的X值
        var imageX: CGFloat = self.center.x - (imageWidth / 2.0)
        
        /// 图片视图的Y值
        let imageY: CGFloat = (self.frame.size.height - imageHeight) / 2.0
        
        startPoint = imageX
        
        let viX: CGFloat = CGFloat(current * 20)
        let viY: CGFloat = 0
        let viWidth: CGFloat = self.frame.size.width
        let viHeight: CGFloat = self.frame.size.height
        
        vi.frame = CGRect(x: viX, y: viY, width: viWidth, height: viHeight)
        vi.backgroundColor = .clear
        
        addSubview(vi)
        
        // 循环创建图片视图对象,并设置其属性
        for i in 0 ..< numberOfPage {
            let imag = UIImageView()
            if i == currentOfPage {
                imag.alpha = 1.0
            }else {
                imag.alpha = 0.4
            }
            imag.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
            imag.layer.cornerRadius = imag.frame.size.height / 2
            imag.backgroundColor = tintColor
            imag.tag = i + 10
            vi.addSubview(imag)
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
        
        let tagValue = getImgViewTagNumber(page) + 10
        
        let nextStart: CGFloat = CGFloat(tagValue - 10) * scrollWidth
        
        /// 移动数值
        let move: CGFloat = 20 * (start - horizontalMoveX) / scrollWidth
        
        /// 透明度
        let Alpha: CGFloat = 0.6 * (horizontalMoveX - nextStart) / scrollWidth
        
        if let ivPage = vi.viewWithTag(tagValue) as? UIImageView, tagValue >= 10 && tagValue + 1 < numberOfPage + 10 {
            
            vi.frame.origin.x = 0 + move
            ivPage.alpha = 1 - Alpha
            
            if let ivPageNext = self.viewWithTag(tagValue + 1) as? UIImageView {
                ivPageNext.alpha = 0.4 + Alpha
            }
        }
        
    }
}
