//
//  QQMusicOperationTool.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/9.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit
import MediaPlayer

class QQMusicOperationTool: NSObject {
    //设置单例，保证每次创建的都是同一个对象
    static let shareInstance = QQMusicOperationTool()
    
    var musicMessage = QQMusicMessageModel()
    
    //音乐列表
    var musicMs: [QQMusicModel]?
    //操作音乐对象
    let tool = QQMusicTool()
    
    
    //音乐角标
    var index = 0 {
        didSet{
            if index < 0 {
                index = (musicMs?.count )! - 1
            }
            if index > (musicMs?.count )! - 1 {
                index = 0
            }
        }
    }
    //返回最新的数据
    func getQQMusicMessage() -> QQMusicMessageModel {
        musicMessage.musicM = musicMs?[index]
        musicMessage.costTime = (tool.avplayer?.currentTime)!
        musicMessage.totalTime = (tool.avplayer?.duration)!
        musicMessage.isPlaying = (tool.avplayer?.isPlaying)!
        
        return musicMessage
        
    }
    //上一首歌曲
    func preMusic()  {
        index -= 1
        
        if let tempList = musicMs {
            //取出模型
            let musicM = tempList[index]
            getPlayMusic(musicM: musicM)
            
        }
    }
    //下一首歌曲
    func nextMusic()  {
        index += 1
        
        if let tempList = musicMs {
            //取出模型
            let musicM = tempList[index]
            getPlayMusic(musicM: musicM)
            
        }
    }
    
    func getPlayMusic(musicM: QQMusicModel)  {
        let fileName = musicM.filename
        tool.getPlayMusic(name: fileName!)
        //容错处理
        if musicMs == nil {
            return
        }
        //记录下当前在播放的音乐索引
        index = (musicMs?.index(of: musicM))!
    }
    
    func playMusic()  {
        tool.resumeMusic()
    }
    func pauseMusic()  {
        tool.pauseMusic()
    }
    
    func setupLockMessage()  {
        
    }
    
    
    
    
    
    
    
    
    
    
    

}
