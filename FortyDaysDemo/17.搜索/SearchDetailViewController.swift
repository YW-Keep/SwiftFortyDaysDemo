//
//  SearchDetailViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/8.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // 数据源
    var data: (image: String, title: String, content: String)
    
    // 这里短短几行代码 水很深 想想为什么这么写，为什么data 赋值在init前面
    init(data: (image: String, title: String, content: String)) {
        self.data = data
        super.init(nibName: "SearchDetailViewController", bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updataUI()
        // Do any additional setup after loading the view.
    }
    
    func updataUI() {
        self.imgView.layer.masksToBounds = true
        let path  = Bundle.main.path(forResource: self.data.image, ofType: "jpg")
        self.imgView?.image = UIImage.init(contentsOfFile: path!)
        self.titleLabel.text =   self.data.title
        self.contentLabel.text =   self.data.content
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
