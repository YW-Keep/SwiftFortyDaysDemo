//
//  LoginViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/2.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    lazy var headImageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 250, width: 216, height: 108))
        imgView.image = UIImage(named: "LoginHeadIcon")!
        imgView.center.x = self.view.center.x
        return imgView
    }()
    
    lazy var leftArmImgView:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: (kScreenWidth - 216)/2.0 + 10, y: 230, width: 40, height: 40))
        imgView.image = UIImage(named: "LoginHand")!
        imgView.isHidden = true
        return imgView
    }()
    
    lazy var rightArmImgView:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: (kScreenWidth + 216)/2.0 - 45 , y: 230, width: 40, height: 40))
        imgView.image = UIImage(named: "LoginHand")!
        imgView.isHidden = true
        return imgView
    }()
    
    lazy var leftHiddenArmImgView:UIImageView = {
        // CGRect(x: (kScreenWidth)/2.0 - 45 , y: 210, width: 40, height: 65) 捂脸状态
        let imgView = UIImageView(frame: CGRect(x: (kScreenWidth - 216)/2.0 + 10, y: 250, width: 40, height: 65))
        imgView.image = UIImage(named: "LoginArmLift")!
        return imgView
    }()
    
    lazy var rightHiddenArmImgView:UIImageView = {
        // CGRect(x: (kScreenWidth )/2.0 + 14, y: 210, width: 40, height: 65) 捂脸状态
        
        let imgView = UIImageView(frame: CGRect(x: (kScreenWidth + 216)/2.0 - 45 , y: 250, width: 40, height: 65))
        imgView.image = UIImage(named: "LoginArmRight")!
        return imgView
    }()
    
    // 输入用户名
    lazy var nameTestField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 40, y: 0, width: kScreenWidth - 80, height: 50))
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor.white
        textField.center.x =  textField.center.x - kScreenWidth
        textField.placeholder = "用户名"
        return textField;
    }()
    
    // 输入账号
    lazy var passwordTestField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 40, y: 70, width: kScreenWidth - 80, height: 50))
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor.white
        textField.center.x =  textField.center.x - kScreenWidth
        textField.placeholder = "密码"
        textField.delegate = self
        return textField;
    }()
    
    // 登录按钮
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x:40 , y: 160, width: kScreenWidth - 80, height: 50)
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.white , for: .normal)
        button.backgroundColor = UIColor(red: 253/255.0, green: 149/255.0, blue: 157/255.0, alpha: 1)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.center.x =  button.center.x - kScreenWidth
        
        return button
    }()
    lazy var backView: UIView  = {
        let view = UIView(frame: CGRect(x: 0, y: 250, width: kScreenWidth, height: 250))
        view.backgroundColor = UIColor(red: 253/255.0, green: 221/255.0, blue: 239/255.0, alpha: 1)
        view.addSubview(nameTestField)
        view.addSubview(passwordTestField)
        view.addSubview(loginButton)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.view.backgroundColor = UIColor(red: 253/255.0, green: 221/255.0, blue: 239/255.0, alpha: 1)
        self.view.addSubview(headImageView)
        self.view.addSubview(leftHiddenArmImgView)
        self.view.addSubview(rightHiddenArmImgView)
        self.view.addSubview(backView)
        self.view.addSubview(leftArmImgView)
        self.view.addSubview(rightArmImgView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 曲线 由块到慢
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.nameTestField.center.x = self.view.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.passwordTestField.center.x = self.view.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
            self.loginButton.center.x = self.view.center.x
        }, completion: nil)
        
        // 猫头鹰动画
         UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveLinear, animations: {
            self.headImageView.frame.origin.y = 150
            
         }, completion: { finished in
            self.leftArmImgView.isHidden = false
            self.rightArmImgView.isHidden = false
         })
    }
    
    @objc func loginAction()  {
    
        let frame = self.loginButton.frame
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            
            self.loginButton.frame = CGRect(x: frame.origin.x - 20, y: frame.origin.y, width: frame.size.width + 40, height: frame.size.height)
            self.loginButton.isEnabled = false
            
        }, completion: { finished in
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
                
                self.loginButton.frame = CGRect(x: frame.origin.x , y: frame.origin.y, width: frame.size.width , height: frame.size.height)
                
            }, completion: { finished in
                self.loginButton.isEnabled = true
            })
        })
        
    
    }
    // MARK - touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameTestField.endEditing(true)
        self.passwordTestField.endEditing(true)

    }
    
    // MARK - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //  捂脸动画
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
            self.leftHiddenArmImgView.frame = CGRect(x: (kScreenWidth)/2.0 - 45 , y: 210, width: 40, height: 65)
            self.rightHiddenArmImgView.frame = CGRect(x: (kScreenWidth )/2.0 + 14, y: 210, width: 40, height: 65)
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
            self.leftArmImgView.isHidden = true
            self.rightArmImgView.isHidden = true
        }, completion: nil)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //  捂脸动画
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
            self.leftHiddenArmImgView.frame = CGRect(x: (kScreenWidth - 216)/2.0 + 10, y: 250, width: 40, height: 65)
            self.rightHiddenArmImgView.frame = CGRect(x: (kScreenWidth + 216)/2.0 - 45 , y: 250, width: 40, height: 65)
        }, completion:{ finished in
            self.leftArmImgView.isHidden = false
            self.rightArmImgView.isHidden = false
        })
    }

}
