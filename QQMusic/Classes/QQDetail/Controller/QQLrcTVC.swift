//
//  QQLrcTVC.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/17.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQLrcTVC: UITableViewController {
    var lrcMs: [QQLrcModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    //设置歌词滚动到中间
    var scrollRow: Int = 0 {
        didSet {
            //防止重复滚动
            if scrollRow != oldValue {
                // 先刷新，再滚动
                let indexPaths = tableView.indexPathsForVisibleRows
                tableView.reloadRows(at: indexPaths!, with: .fade)
                
                let indexPath = IndexPath(row: scrollRow, section: 0)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                
            }
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            let indexPath = IndexPath(row: scrollRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as? QQLrcCell
            
            cell?.progress = progress
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        
    }
    //让歌词头部显示在tableView的中间
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: tableView.height / 2, left: 0, bottom: tableView.height / 2, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lrcMs.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QQLrcCell.getLrcCell(tableView: tableView)
        
        let lrcM = lrcMs[indexPath.row]
        cell.lrcContent = lrcM.lrcStr
        
        if indexPath.row == scrollRow {
            cell.progress = progress
        }else {
            cell.progress = 0
        }

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
