//
//  QQDetailVC.swift
//  QQMusic
//
//  Created by 邓康大 on 2018/2/13.
//  Copyright © 2018年 邓康大. All rights reserved.
//

import UIKit

class QQDetailVC: UIViewController, UIScrollViewDelegate {
    //歌手头像
    @IBOutlet weak var foreImageView: UIImageView!
    //歌词能显示的并且滚动的View
    @IBOutlet weak var lrcBackView: UIScrollView!
    //歌名
    @IBOutlet weak var lrcLabel: UILabel!
    //歌手
    @IBOutlet weak var singerLabel: UILabel!
    //总时间
    @IBOutlet weak var totalLabel: UILabel!
    //背景图片
    @IBOutlet weak var backImageView: UIImageView!
    //播放暂停
    @IBOutlet weak var playOrPause: UIButton!
    
    
    //进度条
    @IBOutlet weak var progressSlider: UISlider!
    //耗时
    @IBOutlet weak var costLabel: UILabel!
    //歌词
    @IBOutlet weak var lyricLabel: QQLrcLabel!
    
    //下一首音乐
    @IBAction func nextButton(_ sender: UIButton) {
        QQMusicOperationTool.shareInstance.nextMusic()
        setupDataOnce()
    }
    //上一首音乐
    @IBAction func previous(_ sender: UIButton) {
        QQMusicOperationTool.shareInstance.preMusic()
        setupDataOnce()
    }
    //播放和暂停
    @IBAction func playOrPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            QQMusicOperationTool.shareInstance.playMusic()
            resumeAnimation()
            
        }else {
            QQMusicOperationTool.shareInstance.pauseMusic()
            pauseAnimation()
            
        }
    }
    //退出
    @IBAction func popVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //展示歌词的View
    lazy var lrcView: QQLrcTVC = {
        return QQLrcTVC()
    }()
        
    
        
    
    //负责更新很多次的timer
    var timer: Timer?
    // 负责更新歌词的link
    var updateLrcLink: CADisplayLink?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLrcView()
        setProgressSlider()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 只需要更新一次的界面更新
        setupDataOnce()
        // 触发需要更新多次的界面更新方法
        addTimer()
        
        addLink()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        
        removeLink()
    }
    // MARK: - 界面操作
    //进度条
    func setProgressSlider()  {
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
    }
    //计算显示歌词的View的frame(执行多次)
    func setupLrcViewFrame()  {
        lrcView.tableView.frame = lrcBackView.bounds
        lrcView.tableView.x = lrcBackView.width
        lrcBackView.contentSize = CGSize(width: lrcBackView.width * 2, height: 0)
    }
    
    //负责添加控件（只需要添加一次即可）
    func addLrcView()  {
        //创建显示歌词的view
        //lrcView = QQLrcTVC()
        //lrcView.tableView.backgroundColor = UIColor.gray
        lrcBackView.addSubview((lrcView.tableView)!)
        lrcBackView.isPagingEnabled = true
        lrcBackView.showsHorizontalScrollIndicator = false
        //设置scrollView的代理
        lrcBackView.delegate = self
    }
    
    //设置圆角图片
    func setupForeImage()  {
        foreImageView.layer.cornerRadius = foreImageView.width / 2
        foreImageView.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //添加旋转动画
    func addAnimation()  {
        //移除上一个动画
        foreImageView.layer.removeAnimation(forKey: "rotation")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 30
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.repeatCount = MAXFLOAT
        //播放完成后不需要移除动画
        animation.isRemovedOnCompletion = false
        foreImageView.layer.add(animation, forKey: "rotation")
        
    }
    //恢复旋转动画
    func resumeAnimation()  {
        foreImageView.layer.resumeAnimate()
    }
    //暂停旋转动画
    func pauseAnimation()  {
        foreImageView.layer.pauseAnimate()
    }
    
    
    
    // MARK: - scrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - scrollView.contentOffset.x / scrollView.width
        foreImageView.alpha = alpha
        lyricLabel.alpha = alpha
        
    }
    // 系统重新布局子控件的方法(在这个方法里面, 可以获取到最后正确的frame, 所以, 一般把控件的布局, 写到这个位置,该方法频繁调用)
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLrcViewFrame()
        setupForeImage()
    }
    
    // MARK: - 业务逻辑
    //当歌曲切换时,只需要设置一次的数据
    func setupDataOnce()  {
        let musicMessageModel = QQMusicOperationTool.shareInstance.getQQMusicMessage()
        lrcLabel.text = musicMessageModel.musicM?.name
        
        if musicMessageModel.musicM?.icon != nil {
            backImageView.image = UIImage(named: (musicMessageModel.musicM?.icon)!)
            foreImageView.image = UIImage(named: (musicMessageModel.musicM?.icon)!)
        }
        
        singerLabel.text = musicMessageModel.musicM?.singer
        totalLabel.text = QQTimeTool.getTime(time: musicMessageModel.totalTime)
        
        //开始动画
        addAnimation()
        
        if musicMessageModel.isPlaying {
            resumeAnimation()
        }else {
            pauseAnimation()
        }
        
        //切换最新的歌词
        let lrcMs = QQMusicDataTool.getLrcMusicData(fileName: musicMessageModel.musicM?.lrcname)
        lrcView.lrcMs = lrcMs
        
        
    }
    //当歌曲切换时,设置多次的数据
    @objc func setupDataTimes()  {
        let musicMessageModel = QQMusicOperationTool.shareInstance.getQQMusicMessage()
        costLabel.text = QQTimeTool.getTime(time: musicMessageModel.costTime)
        progressSlider.value = Float(musicMessageModel.costTime / musicMessageModel.totalTime)
        playOrPause.isSelected = musicMessageModel.isPlaying
        
    }
    // 执行多次更新方法的定时器
    func addTimer()  {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailVC.setupDataTimes), userInfo: nil, repeats: true)
        //将定时器添加到主运行循环中
        RunLoop.current.add(timer!, forMode: .commonModes)
        
    }
    func removeTimer()  {
        timer?.invalidate()
        timer = nil
    }
    
    func addLink()  {
        updateLrcLink = CADisplayLink(target: self, selector: #selector(updateLrc))
        updateLrcLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    func removeLink()  {
        updateLrcLink?.invalidate()
        updateLrcLink = nil
    }
    
    
    
    //更新滚动歌词
    @objc func updateLrc()  {
        let musicMessageModel = QQMusicOperationTool.shareInstance.getQQMusicMessage()
        
        let rowLrcm = QQMusicDataTool.getLrcMusicRow(current: musicMessageModel.costTime, lrcModels: (lrcView.lrcMs))
        let row = rowLrcm.row
        lrcView.scrollRow = row
        
        let lrcm = rowLrcm.lrcM
        lyricLabel.text = lrcm?.lrcStr
        
        
        //歌词进度
        if let lrcm = lrcm {
            let value =  CGFloat((musicMessageModel.costTime - lrcm.beginTime) / (lrcm.endTime - lrcm.beginTime))
            lyricLabel.progress = value
        }
        
        
        lrcView.progress = lyricLabel.progress
        
        //设置锁屏中心界面
        if UIApplication.shared.applicationState == .background {
            QQMusicOperationTool.shareInstance.setupLockMessage()
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
