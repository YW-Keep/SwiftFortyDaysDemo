//
//  CameraViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/31.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import AVFoundation

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
        } else if authStatus == .notDetermined{
            if !AVCaptureDevice.devices(for: AVMediaType.video).isEmpty {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    // 首次授权 用户没有给予照相机访问的权限 => 返回上一层处理
                    DispatchQueue.main.async {
                        if granted {
                          self.openCamera()
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func openPhotoAlbum() {
        pickVC.sourceType = .photoLibrary
        self.present(pickVC, animated: true, completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image;
            if picker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
        picker.dismiss(animated: true, completion: nil)
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
