//
//  QQMusicMessageModel.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/14.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {
    //让该模型拥有显示歌单模型
    var musicM: QQMusicModel?
    
    var costTime: TimeInterval = 0
    
    var totalTime: TimeInterval = 0
    
    var isPlaying: Bool = false
    
    
    
}
