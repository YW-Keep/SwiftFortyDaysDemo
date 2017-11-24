//
//  CalculatorViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/23.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

//  这里定义了运算符枚举值，其中 数字代表相应运算符的View tage 值
enum Operator: Int {
    case none = 0
    case add = 300
    case subtraction = 301
    case multiplication = 302
    case division = 303
}

class CalculatorViewController: UIViewController {
    
    // 展示的label
    @IBOutlet weak var showLabel: UILabel!
    
    // 运算符
    var selectorOperator: Operator = .none
    
    // 第一个数
    var firstNumString: String = ""
    
    // 第二个数
    var secondNumString: String = ""
    
    // 结果数
    var isGetResult: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "计算器"

        self.navBarAlpha = 0
        self.navBarTintColor = .white
        print(Int.max)
        print(LONG_MAX)
        print(LONG_LONG_MAX)
        

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
    
    // 点击运算符
    @IBAction func OperatorAction(_ sender: UIButton) {
        
        if selectorOperator != .none && firstNumString.count > 0 && secondNumString.count > 0  && !isGetResult {
            computationsResult()
        }
        
        if isGetResult {
            secondNumString = ""
            isGetResult =  false
        }
        
        if selectorOperator.rawValue == sender.tag && sender.isSelected {
            return
        }
        
        cancelOperatorSelector()
        sender.isSelected = !sender.isSelected
        selectorOperator = Operator(rawValue: sender.tag)!
    }
    
    // 点击数字
    @IBAction func addNumAction(_ sender: UIButton) {
        
        if isGetResult {
            reset()
        }
        cancelOperatorSelector()
        
        let addNum = String(sender.tag - 210)
        
        if selectorOperator == .none {
            if addNum == "0" && firstNumString.count == 0 {
                return
            } else {
                firstNumString = firstNumString + addNum
                showLabel.text = firstNumString
            }
        } else {
            if secondNumString == "0" {
                secondNumString = addNum
            } else {
                secondNumString = secondNumString + addNum
            }
            showLabel.text = secondNumString
        }
    }
    
    // 计算点击后调用
    @IBAction func computationAction(_ sender: UIButton) {
        cancelOperatorSelector()
        computationsResult()
    }
    
    // 复位点击后调用
    @IBAction func resetAction(_ sender: UIButton) {
        reset()
    }
    
    // 计算方法
    private func computationsResult() {
    
        guard selectorOperator != .none && secondNumString.count > 0  else {
            return
        }
        
        let firstNum = Int(firstNumString.count == 0 ? "0" : firstNumString)!
        let secondNum = Int(secondNumString)!
        var resultString = ""
        switch selectorOperator {
        case .add:
            resultString = String(firstNum + secondNum)
        case .subtraction:
            resultString = String(firstNum - secondNum)
        case .multiplication:
            resultString = String(firstNum * secondNum)
        case .division:
            if secondNum == 0 {
                resultString = "错误"
            } else {
                resultString = String(firstNum / secondNum)
            }
        default: break
            
        }
        isGetResult = true
        if resultString != "错误" {
            firstNumString = resultString
        } else {
            reset()
        }
        showLabel.text = resultString
    }
    
    // 复位
    private func reset() {
        firstNumString = ""
        secondNumString = ""
        isGetResult = false
        cancelOperatorSelector()
        showLabel.text = "0"
    }
    
    // 取消运算符选中
    private func cancelOperatorSelector() {
        if selectorOperator.rawValue > 0 {
            let button = self.view.viewWithTag(selectorOperator.rawValue) as! UIButton
            button.isSelected = false
        }
    }
}
