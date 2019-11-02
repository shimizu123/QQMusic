//
//  QQLrcLabel.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/17.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQLrcLabel: UILabel {
    //歌词进度
    var progress: CGFloat = 0 {
        didSet {
            //重绘
            setNeedsDisplay()  //会自动调用 draw方法
        }
    }
    

  
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 设置填充颜色
        UIColor.green.set()
        
        let fillRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * progress, height: rect.size.height)
        
        UIRectFillUsingBlendMode(fillRect, .sourceIn)
        
    }
 

}
