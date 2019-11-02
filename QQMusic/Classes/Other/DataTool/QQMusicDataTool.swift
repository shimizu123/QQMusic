//
//  QQMusicDataTool.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/5.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {
    //用来返回数据模型
    class func getMusicList(result: ([QQMusicModel]) ->()) {
        //加载本地的plist文件
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            result([QQMusicModel]())
            return
        }
        
        //加载文件内容
        guard let dictArray = NSArray(contentsOfFile: path) else {
            result([QQMusicModel]())
            return
        }
        
        //把字典转成模型
        var musicMs = [QQMusicModel]()
        //遍历
        for dict in dictArray {
            let musicM = QQMusicModel(dict: dict as! [String: Any])
            musicMs.append(musicM)
        }
        
        //以闭包的形式返回出去
        result(musicMs)
        
        
    }
    //返回具体某一行歌词，采用元组的方式来达到读取歌词的经度
    class func getLrcMusicRow(current: TimeInterval, lrcModels: [QQLrcModel]) -> (row: Int, lrcM: QQLrcModel?) {
        let count = lrcModels.count
        for i in 0..<count {
            let lrcM = lrcModels[i]
            
            if lrcM.beginTime < current && lrcM.endTime > current {
                return (i, lrcM)
            }
            
        }
        return (0, QQLrcModel())
    }
    //处理歌词
    class func getLrcMusicData(fileName: String?) -> [QQLrcModel] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else { return [QQLrcModel]() }
        
        var contentLrc = ""
        do {
            contentLrc = try String(contentsOfFile: path)
        } catch  {
            print(error)
            return [QQLrcModel]()
        }
        //将歌词转成一行一行组成的数组
        let lrcArray = contentLrc.components(separatedBy: "\n")
        
        var lrcMs = [QQLrcModel]()
        
        for lrcmStr in lrcArray {
            //过滤掉垃圾数据
            if lrcmStr.contains("[ti:") || lrcmStr.contains("[ar:") || lrcmStr.contains("[al:") {
                continue
            }
            //替换
            let resultStr = lrcmStr.replacingOccurrences(of: "[", with: "")
            //开始解析
            let timeAndContent = resultStr.components(separatedBy: "]")
            if timeAndContent.count != 2 {
                continue
                
            }
            let time = timeAndContent[0]
            let content = timeAndContent[1]
            
            
            // 创建歌词数据模型，进行赋值
            let lrcM = QQLrcModel()
            lrcM.beginTime = QQTimeTool.getTimeInterval(formatTime: time)
            lrcM.lrcStr = content
            lrcMs.append(lrcM)
            
            
            //遍例所有的数组中的时间
            let count = lrcMs.count
            for i in 0..<count {
                if i != count - 1 {
                    lrcMs[i].endTime = lrcMs[i+1].beginTime
                }
                
            }
            
            
        }
        
        
        //返回处理好的时间和歌词
        return lrcMs
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
