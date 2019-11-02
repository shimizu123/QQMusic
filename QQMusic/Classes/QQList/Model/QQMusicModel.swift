//
//  QQMusicModel.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/5.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {
    //歌曲名称
    var name: String?
    //歌曲文件名称
    var filename: String?
    //歌曲文件名称
    var lrcname: String?
    
    var singer: String?
    
    var singerIcon: String?
    //专辑图片
    var icon: String?
    
    //用KVC的方式来实现转模型，此方法必须重写
    override init() {
        super.init()
    }
    //KVC
    init(dict: [String: Any]) {
        super.init()
        //setValuesForKeys(dict)
        
        name = dict["name"] as? String
        filename = dict["filename"] as? String
        lrcname = dict["lrcname"] as? String
        singer = dict["singer"] as? String
        singerIcon = dict["singerIcon"] as? String
        icon = dict["icon"] as? String
    }

    //容错处理，key和value对不上号的情况
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
  
}
