//
//  DateSelectionViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/10/25.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class DateSelectionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    var timer : Timer!
    var firstNum = 0
    var secondNum = 0
    var thirdNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "日期选择器"
        pickerView.delegate = self
        pickerView.dataSource = self
        // 默认选中
        pickerView.selectRow(8000, inComponent: 0, animated: true)
        pickerView.selectRow(8000, inComponent: 1, animated: true)
        pickerView.selectRow(8000, inComponent: 2, animated: true)
        pickerView.isUserInteractionEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (timer != nil) {
            timer.invalidate()
        }
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        // yyyy年MM月dd日 HH:mm:ss
        dformatter.dateFormat = "yyyy年MM月dd日"
        // 使用日期格式器格式化日期、时间
        self.title = dformatter.string(from: datePicker.date)
        
    }
    
    @IBAction func begainAction(_ sender: UIButton) {
        if !(firstNum == 0 && secondNum == 0 && thirdNum == 0) {
            return
        }
        // 初始化
        pickerView.selectRow(8000, inComponent: 0, animated: false)
        pickerView.selectRow(8000, inComponent: 1, animated: false)
        pickerView.selectRow(8000, inComponent: 2, animated: false)
        firstNum = Int(150 + arc4random_uniform(10))
        secondNum = Int(170 + arc4random_uniform(10))
        thirdNum = Int(190 + arc4random_uniform(10))
        print("\(firstNum) + \(secondNum) + \(thirdNum)")
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.replyAction), userInfo: nil, repeats: true)
    }
    @objc func replyAction() {
        if firstNum > 0 {
            firstNum = firstNum - 1
            pickerView.selectRow(pickerView.selectedRow(inComponent: 0)+1, inComponent: 0, animated: true)
        }
        
        if secondNum > 0 {
            secondNum = secondNum - 1
            pickerView.selectRow(pickerView.selectedRow(inComponent: 1)+1, inComponent: 1, animated: true)
        }
        
        if thirdNum > 0 {
            thirdNum = thirdNum - 1
            pickerView.selectRow(pickerView.selectedRow(inComponent: 2)+1, inComponent: 2, animated: true)
        }
        
        if (firstNum == 0 && secondNum == 0 && thirdNum == 0) {
            timer.invalidate()
            return
        }

    }
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 16000
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(component) + "-" + String(row%10)
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         pickerView.selectRow(8000 + row%10, inComponent: component, animated: false)
    }
    
    deinit {
        print("选择器页面释放")
    }
}
