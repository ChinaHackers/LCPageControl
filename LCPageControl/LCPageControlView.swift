//
//  LCPageControlView.swift
//  LCPageControlExample
//
//  Created by Liu Chuan on 2018/2/1.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit


/// 屏幕的宽度
let screenW: CGFloat = UIScreen.main.bounds.size.width

/// 屏幕的高度
let screenH: CGFloat = UIScreen.main.bounds.size.height

/// 获取图片视图的tag值
///
/// - Parameter page: 页码
/// - Returns: tag值
public func getImgViewTagNumber(_ page: CGFloat) -> Int {
    /// 临时常量
    let temp = page - 0.02
    return Int(temp)
}


@IBDesignable public class LCPageControlView: UIView {


    /// 页面指示器的样式风格
    ///
    /// - Normal: 默认
    /// - CircleMove: 圆圈移动
    /// - FillCircle: 填充圆
    /// - FlatBar: 扁条
    public enum LCPageStyle: Int {
        case Normal = 100
        case CircleMove
        case FillCircle
        case FlatBar
    }
    
    public var pageStyle: LCPageStyle = .Normal
    
    var numberOfPage: Int = 0
    
    var currentOfPage: Int = 0
    
    var startPoint: CGFloat = 0.0
    
    var start: CGFloat = 0.0
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    /// 配置页码指示器视图
    ///
    /// - Parameters:
    ///   - page: 页码
    ///   - current: 当前页码
    ///   - tColor: 颜色
    func configPageView(_ page: Int, current: Int, tColor: UIColor) {
        
        let viewFrame = calculateViewRealSize()
        
        switch pageStyle {
        case .CircleMove:   // 圆圈移动
            let circleM = LCPageControlCircleMove(frame: viewFrame)
            circleM.tag = pageStyle.rawValue
            circleM.configCircleMoveStylePageView(page, current: current, tintColor: tColor)
            addSubview(circleM)
        case .FillCircle:   // 填充圆
            let fillCircle = LCPageControlFillCircle(frame: viewFrame)
            fillCircle.tag = pageStyle.rawValue
            fillCircle.configFillCircleStylePageView(page, current: current, tintColor: tColor)
            addSubview(fillCircle)
        case .FlatBar:      // 扁平条
            let flatBar = LCPageControlFlatBar(frame: viewFrame)
            flatBar.tag = pageStyle.rawValue
            flatBar.configFlatBarStylePageView(page, current: current, tintColor: tColor)
            addSubview(flatBar)
        default:            // Normal
            let normal = LCPageControlNormal(frame: viewFrame)
            normal.tag = pageStyle.rawValue
            normal.configNormalStylePageView(page, current: current, tintColor: tColor)
            addSubview(normal)
        }
        
    }
    
    //MARK: 计算实际尺寸
    /// 计算实际尺寸
    ///
    /// - Returns: 尺寸大小
    func calculateViewRealSize() -> CGRect {
        var viewFrame = self.bounds
        if self.constraints.count != 0 {
            viewFrame.size.width = screenW
        }
        for element in self.constraints {
            if element.firstAttribute == NSLayoutAttribute.height {
                viewFrame.size.height = element.constant
            } else if element.firstAttribute == NSLayoutAttribute.width {
                viewFrame.size.width = element.constant
            }
        }
        return viewFrame
    }

    //MARK: 滚动视图移动方法
    open func scrollDid(_ scrollView: UIScrollView) {
        
        switch pageStyle {
        case .CircleMove:
            guard let circleM = self.viewWithTag(pageStyle.rawValue) as? LCPageControlCircleMove else {return}
            circleM.scrollVDid(scrollView)
        case .FillCircle:
            guard let fillCircle = self.viewWithTag(pageStyle.rawValue) as? LCPageControlFillCircle else {return}
            fillCircle.scrollVDid(scrollView)
        case .FlatBar:
            guard let flatBar = self.viewWithTag(pageStyle.rawValue) as? LCPageControlFlatBar else {return}
            flatBar.scrollVDid(scrollView)
        default:     // Normal
            guard let normal = self.viewWithTag(pageStyle.rawValue) as? LCPageControlNormal else {return}
            normal.scrollVDid(scrollView)
        }
    }
    
}
