//
//  RecorderManager.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/16.
//  Copyright © 2017年 Tang. All rights reserved.
//

import Foundation
import AVFoundation

@objc protocol RecorderManagerDeleagte {
    
   @objc optional func endPlay()
    
   @objc optional func endAddRecord()
}

class RecorderManager:NSObject, AVAudioPlayerDelegate {
    
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    
    // 协议
    var delegate : RecorderManagerDeleagte?
    
    let tem_path = NSTemporaryDirectory() + "tempAudio.m4a"
    let storage_path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first?.appending("/records")
    
    // 开始录音
    func begainRecord() {
        
        let session = AVAudioSession.sharedInstance()
        //设置session类型
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let err{
            print("设置类型失败:\(err.localizedDescription)")
        }
        //设置session动作
        do {
            try session.setActive(true)
        } catch let err {
            print("初始化动作失败:\(err.localizedDescription)")
        }
        
        //录音设置，注意，后面需要转换成NSNumber，如果不转换，你会发现，无法录制音频文件，我猜测是因为底层还是用OC写的原因
        if recorder == nil {
            let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 44100),//采样率
                AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),//音频格式
                AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
                AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
                AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
            ];
            
            //开始录音
            do {
                let url = URL(fileURLWithPath: tem_path)
                recorder = try AVAudioRecorder(url: url, settings: recordSetting)
                recorder!.prepareToRecord()
                recorder!.record()
                print("开始录音")
            } catch let error {
                print("录音失败:\(error.localizedDescription)")
            }
        } else {
            recorder!.record()
        }
    }
    
    // 暂停录音
    func pauseRecord() {
        recorder!.pause()
    }
    
    //结束录音
    func stopRecord() {
        if let recorder = self.recorder {
            if recorder.isRecording {
                print("正在录音，马上结束它，文件保存到了：\(tem_path)")
            }else {
                print("没有录音，但是依然结束它")
            }
            recorder.stop()
        }else {
            print("没有初始化")
        }
    }
    //删除录音
     private func deleteVideo(path: String) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: path)
        } catch let error {
            print("删除失败:\(error.localizedDescription)")
        }
    }
    
    func deleteVideo(name: String) {
        deleteVideo(path: storage_path! + "/\(name)")
    }
    func deleteVideo() {
        deleteVideo(path:tem_path)
    }
    
    //保存录音
    func saveVideo(name: String){
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: storage_path!) {
            do {
                try fileManager.createDirectory(atPath: storage_path!, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                 print("创建:\(error.localizedDescription)")
            }
        }
        do {
      
            let path = storage_path! + "/\(name).m4a"
            try fileManager.moveItem(atPath: tem_path, toPath: path)
            delegate?.endAddRecord?()
        } catch let error {
            print("保存失败:\(error.localizedDescription)")
        }
    }
}

// 播放相关
extension RecorderManager {

    
    //播放(默认缓存)
    func play() {
      play(path: tem_path)
    }
    
    func play(name: String) {
         play(path: storage_path! + "/\(name)")
    }
    
    private func play(path: String) {
        if player == nil {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player?.delegate = self
                print("长度：\(player!.duration)")
                player!.play()
            } catch let error {
                print("播放失败:\(error.localizedDescription)")
            }
        } else {
            player!.play()
        }
    }
    
    // 暂停
    func pausePlay() {
        if player != nil &&  player!.isPlaying {
           player!.pause()
        }
    }
    
    func stopPlay() {
        if player != nil {
            player!.stop()
            player = nil
        }
    }
    
    //  获取播放列表
    func getNameList() -> [String] {
        let fileManager = FileManager.default
        
        return fileManager.subpaths(atPath: storage_path!) ?? []
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.endPlay?()
    }
    
}
