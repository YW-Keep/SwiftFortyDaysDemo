//
//  BookDetailViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/22.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    // 书图片
    @IBOutlet weak var bookImageView: UIImageView!
    // 书名
    @IBOutlet weak var bookNameLabel: UILabel!
    // 描述
    @IBOutlet weak var profileLabel: UILabel!
    // 作者
    @IBOutlet weak var authorLabel: UILabel!
    // 出版社
    @IBOutlet weak var publishLabel: UILabel!
    // 价格
    @IBOutlet weak var priceLabel: UILabel!
    
    var bookId: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图书详情"
        // Do any additional setup after loading the view.
        Request.requestBookDetailNew(bookId: bookId!) { (model) in
            DispatchQueue.main.async {
                self.bookImageView.sd_setImage(with: URL(string: model.bookImg), placeholderImage: UIImage(named: "defaultImg"))
                self.bookNameLabel.text = model.bookName
                self.profileLabel.text = model.summary
                var names = ""
                for name in model.author {
                    if names.count == 0 {
                        names = name
                    } else {
                        names = names + "," + name
                    }
                }
                self.authorLabel.text = "作者：  " + names
                self.publishLabel.text = "出版社：  " + model.publisher
                self.priceLabel.text = "价格：  " + model.price
            }
        }
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
