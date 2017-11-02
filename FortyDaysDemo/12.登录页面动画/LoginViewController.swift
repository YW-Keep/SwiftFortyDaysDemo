//
//  LoginViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/2.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var nameTestField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 40, y: 100, width: kScreenWidth - 80, height: 50))
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor.white
        textField.center.x =  textField.center.x - kScreenWidth
        return textField;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.view.backgroundColor = UIColor(red: 253/255.0, green: 221/255.0, blue: 239/255.0, alpha: 1)
        self.view.addSubview(nameTestField)
        // Do any additional setup after loading the view.
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
