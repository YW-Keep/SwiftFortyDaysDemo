//
//  LoginAnimationViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/2.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class LoginAnimationViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: (kScreenWidth - kScreenWidth/2.0*1.5)/2.0, y: 250, width: kScreenWidth/2.0*1.5, height: kScreenWidth/2.0 * 9 / 32))
//        imgView.center = self.view.center
        imgView.image = UIImage(named: "LoginImg")
        return imgView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 40, y: kScreenHeight - 100, width: kScreenWidth - 80, height: 50)
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 253/255.0, green: 149/255.0, blue: 157/255.0, alpha: 1)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    lazy var signButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 40, y: kScreenHeight - 170, width: kScreenWidth - 80, height: 50))
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor(red: 253/255.0, green: 149/255.0, blue: 157/255.0, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.white
//        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录页面"
        self.view.backgroundColor = UIColor(red: 253/255.0, green: 221/255.0, blue: 239/255.0, alpha: 1)
        self.view.addSubview(loginButton)
        self.view.addSubview(imageView)
        self.view.addSubview(signButton)
        // Do any additional setup after loading the view.
    }
    @objc func loginAction()  {
        self.navigationController?.pushViewController(LoginViewController(), animated: false)
    }

}
