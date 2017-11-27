//
//  DrawersLeftViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/27.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class DrawersLeftViewController: UIViewController {

    weak var mainCol: DrawersBaseViewControntroller?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "StarrySky.jpg")
        self.view.addSubview(imageView)
        
        let button = UIButton(frame: CGRect(x: 30, y: 100, width: 60, height: 60))
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.setTitle("测试咯", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(self.pushAction), for: .touchUpInside)
        self.view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    
    @objc func pushAction() {
        self.mainCol?.tapAction()
        self.mainCol?.mainCol .pushViewController(WaterfallFlowViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
