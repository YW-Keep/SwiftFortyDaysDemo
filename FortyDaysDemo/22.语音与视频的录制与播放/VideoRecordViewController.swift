//
//  VideoRecordViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/17.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices

// 这里就用最简单的 调用系统的UIImagePickerController 来进行录制了。
// 因为之前做过文件处理 这里就不做了 要自定义页面也可以使用 AVFoundation 这个框架来完成这个功能
class VideoRecordViewController: UIViewController {
    
    var videoURL: URL?
    private lazy var pickerCol: UIImagePickerController = {
        let pickerCol = UIImagePickerController()
        pickerCol.delegate = self
        pickerCol.allowsEditing = true
        pickerCol.sourceType = .camera
        pickerCol.mediaTypes = [kUTTypeMovie as String]  // 拍摄类型 默认为照片
        pickerCol.videoMaximumDuration = 10      // 最大时长 其实默认就是10秒
        pickerCol.videoQuality = .typeHigh       //画质 我这里用了高清
        return pickerCol
    }()
    
    let tem_path = NSTemporaryDirectory() + "tempVideo.mp4"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "视频录制"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordAction(_ sender: UIButton) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == .authorized {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.present(pickerCol, animated: true, completion: nil)
            } else {
                print("没有相机可用")
            }
        } else if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (isAllow) in
                if isAllow {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        self.present(self.pickerCol, animated: true, completion: nil)
                    } else {
                        print("没有相机可用")
                    }
                }
            })
        } else {
            //  弹出Aler弹窗 询问是否需要在设置中 开启照相机访问权限
            let alert = UIAlertController(
                title: "没有相机权限",
                message: "现在就去设置里修改权限呀",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "现在就去", style: .cancel, handler: { (alert) -> Void in
                UIApplication.shared.open((NSURL(string: UIApplicationOpenSettingsURLString)! as URL), options: [:], completionHandler: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }

    
    @IBAction func playAction(_ sender: UIButton) {
        if videoURL != nil {
            let playerView = AVPlayerViewController()
            let player = AVPlayer.init(url: videoURL!)
            playerView.player = player
            self.showDetailViewController(playerView, sender: nil)
            player.play()
        } else {
            print("没有拍摄视频")
        }
    }
    
}

extension VideoRecordViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeMovie as String {
            videoURL = info[UIImagePickerControllerMediaURL] as? URL
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}
