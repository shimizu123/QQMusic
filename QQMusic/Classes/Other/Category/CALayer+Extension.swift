//
//  CALayer+Extension.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/16.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit


extension CALayer {
    //暂停动画
    func pauseAnimate()  {
        let pausedTime: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
        
    }
    //恢复动画
    func resumeAnimate()  {
        let pausedTime: CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
        
        
    }
}
