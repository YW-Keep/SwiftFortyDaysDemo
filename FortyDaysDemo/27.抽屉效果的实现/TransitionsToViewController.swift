//
//  TransitionsToViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/28.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TransitionsToViewController: UIViewController, TransitionManagerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = #imageLiteral(resourceName: "StarrySky.jpg")
        imageView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    func dismiss() {
         self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("\(self.description)释放")
    }
}
