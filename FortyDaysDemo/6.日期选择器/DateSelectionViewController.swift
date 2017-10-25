//
//  DateSelectionViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/10/25.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class DateSelectionViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "日期选择器"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
