//
//  ViewController.swift
//  LCPageControlExample
//
//  Created by Liu Chuan on 2018/1/31.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// LCPageControlView
    let pageControl = LCPageControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        /// UIScrollView
        let scroll = UIScrollView(frame: self.view.bounds)
        scroll.contentSize = CGSize(width: screenW * 5, height: screenH)
        scroll.delegate = self
        scroll.isPagingEnabled = true
        
        /** LCPageControlView **/
        pageControl.frame = CGRect(x: 0, y: screenH - 150, width: screenW, height: 50)
        pageControl.pageStyle = .FillCircle
        pageControl.configPageView(5, current: 0, tColor: .white)
        
        view.addSubview(scroll)
        view.addSubview(pageControl)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scrollDid(scrollView)
    }
}
