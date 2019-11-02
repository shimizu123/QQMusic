//
//  QQListTVC.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/9.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQListTVC: UITableViewController {
    //只要有数据变化，就刷新tableView
    var musicMs: [QQMusicModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        QQMusicDataTool.getMusicList { (models) in
            
            //将返回的数组装入模型中
            self.musicMs = models
            QQMusicOperationTool.shareInstance.musicMs = models
        }
        

        
    }
    
    func setupUI()  {
        tableView.backgroundView = UIImageView(image:UIImage(named: "QQListBack.jpg"))
        tableView.rowHeight = 60
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return musicMs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //通过方法获得cell
        let cell = QQMusicListCell.cellWithTableView(tableView: tableView)
        
        let musicM = musicMs[indexPath.row]
       
        cell.musicM = musicM
        
        cell.beginAnimation(type: .translation)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musicM = musicMs[indexPath.row]
        QQMusicOperationTool.shareInstance.getPlayMusic(musicM: musicM)
        performSegue(withIdentifier: "ListToDetail", sender: nil)
    }
    //实现一种动画效果
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取指定的cell
        guard let indexRows = tableView.indexPathsForVisibleRows else { return }
        //获取中间的cell
        let firstCell = indexRows.first?.row
        let lastCell = indexRows.last?.row
        //计算中间的cell
        let middleCell = Int(Float(firstCell! + lastCell!) / 2)
        for indexRow in indexRows {
            let cell = tableView.cellForRow(at: indexRow)
            cell?.x = CGFloat(abs(indexRow.row - middleCell) * 40)
            
            
        }
        
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
