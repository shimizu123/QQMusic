//
//  QQMusicListCell.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/9.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit
//动画的样式
enum AnimationType {
    case rotation, translation
}

class QQMusicListCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singerName: UILabel!
    //重写模型的set方法，用模型给属性赋值
    var musicM: QQMusicModel? {
        didSet{
            //容错处理
            if musicM?.singerIcon != nil {
                iconImageView.image = UIImage(named: (musicM?.singerIcon)!)
            }
            
            songName.text = musicM?.name
            singerName.text = musicM?.singer
        }
    }
    //加载xib时一定会调用
    override func awakeFromNib() {
        super.awakeFromNib()
        // 处理头像
        iconImageView.layer.cornerRadius = iconImageView.width / 2
        iconImageView.layer.masksToBounds = true
    }
    //返回由xib创建的cell
    class func cellWithTableView(tableView: UITableView) -> QQMusicListCell {
        let cellID = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQMusicListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("QQMusicListCell", owner: nil, options: nil)?.first as? QQMusicListCell
        }
        
        return cell!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func beginAnimation(type: AnimationType)  {
        switch type {
        case .rotation:
            self.layer.removeAnimation(forKey: "rotation")
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.values = [M_PI / 4, 0]
            animation.duration = 0.2
            self.layer.add(animation, forKey: "rotation")
        case .translation:
            self.layer.removeAnimation(forKey: "translation")
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.values = [60, 0]
            animation.duration = 0.3
            self.layer.add(animation, forKey: "translation")
            
        }
        
        
        
        
        
        
    }

}
