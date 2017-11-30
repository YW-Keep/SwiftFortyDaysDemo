//
//  NewsModel.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/30.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
class NewsListModel {
    var title: String {
        didSet{
            computationsWidth()
        }
    }
    var width: CGFloat = 0
    init(_ title :String) {
        self.title = title
        computationsWidth()
    }
    private func computationsWidth() {
        width = title.size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)]).width
    }
}
