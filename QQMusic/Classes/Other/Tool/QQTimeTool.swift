//
//  QQTimeTool.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/16.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {
    //转化为具体的分钟和秒钟,比如21.123
    class func getTime(time: TimeInterval) -> String {
        let min = Int(time / 60)
        let sec = Int(time) % 60
        //转成字符串
        let resultStr = String(format: "%02d:%02d", min, sec)
        
        return resultStr
        
    }
    
    class func getTimeInterval(formatTime: String) -> TimeInterval {
        // 00:33.20
        let minSec = formatTime.components(separatedBy: ":")
        if minSec.count != 2 {
            return 0
        }
        
        let min = TimeInterval(minSec[0])
        let sec = TimeInterval(minSec[1])
        
        
        return min! * 60 + sec!
        
    }

}
