//
//  QQLrcCell.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/17.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQLrcCell: UITableViewCell {

    @IBOutlet weak var lrcLabel: QQLrcLabel!
    //歌词进度
    var progress: CGFloat = 0 {
        didSet {
            lrcLabel.progress = progress
        }
    }
    
    var lrcContent: String = "" {
        didSet {
            lrcLabel.text = lrcContent
        }
    }
    
    class func getLrcCell(tableView: UITableView) -> QQLrcCell {
        let lrcCellID = "Lrc"
        var cell = tableView.dequeueReusableCell(withIdentifier: lrcCellID) as? QQLrcCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("QQLrcCell", owner: nil, options: nil)?.first as? QQLrcCell
        }
        
        return cell!
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
