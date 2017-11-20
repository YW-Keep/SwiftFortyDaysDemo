//
//  SlotMachinesViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/20.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class SlotMachinesViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var bounds: CGRect = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "老虎机"
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isUserInteractionEnabled = false
        
        imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
        
        for _ in 1...100 {
            dataArray1.append((Int)(arc4random() % 10 ))
            dataArray2.append((Int)(arc4random() % 10 ))
            dataArray3.append((Int)(arc4random() % 10 ))
        }
        resultLabel.text = ""
        self.pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 0, animated: false)
        self.pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 1, animated: false)
        self.pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 2, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goAction(_ sender: UIButton) {
        
        self.pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 0, animated: true)
        self.pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 1, animated: true)
        self.pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 2, animated: true)
        
        if(dataArray1[pickerView.selectedRow(inComponent: 0)] == dataArray2[pickerView.selectedRow(inComponent: 1)] && dataArray2[pickerView.selectedRow(inComponent: 1)] == dataArray3[pickerView.selectedRow(inComponent: 2)]) {
            
            resultLabel.text = "Bingo!"
            
        } else {
            
            resultLabel.text = "💔"
            
        }
    }

}

extension SlotMachinesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let  pickerLabel = UILabel()
        if component == 0 {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
}
