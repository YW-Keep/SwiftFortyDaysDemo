//
//  CameraViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/31.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    private lazy var pickVC: UIImagePickerController = {
        let VC = UIImagePickerController()
        VC.delegate = self
        VC.allowsEditing = true
        return VC
    }()
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "拍照"
        imageView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPictureAction(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "上传照片呀", message: "大头照", preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "相机", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.openPhotoAlbum()
        }))
        actionSheet.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func openCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == .authorized {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickVC.sourceType = .camera
                self.present(pickVC, animated: true, completion: nil)
            } else {
                print("没有相机可用")
            }
        } else if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (isAllow) in
                if isAllow {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        self.pickVC.sourceType = .camera
                        self.present(self.pickVC, animated: true, completion: nil)
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
    
    func openPhotoAlbum() {
        let authorizationStatus  =  PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            pickVC.sourceType = .photoLibrary
            self.present(pickVC, animated: true, completion: nil)
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if(status == .authorized) {
                    self.pickVC.sourceType = .photoLibrary
                    self.present(self.pickVC, animated: true, completion: nil)
                }
            })
        } else {
            //  弹出Aler弹窗 询问是否需要在设置中 开启照相机访问权限
            let alert = UIAlertController(
                title: "没有相册权限呀",
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image;
            if picker.sourceType == .camera {
                self.addPicture(image)
            }
        }
    }
    func addPicture(_ image: UIImage) {
        // 权限判断，如果允许就保存图片，没有权限就弹出弹框提示
        let authorizationStatus  =  PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if(status == .authorized) {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
                }
            })
            
        } else {
            //  弹出Aler弹窗
            let alert = UIAlertController(
                title: "没有保存照片权限呀",
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
    // 保存图片回调
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        
        if didFinishSavingWithError != nil {
            print("保存失败")
            return
        }
        print("保存成功")
    }

}
