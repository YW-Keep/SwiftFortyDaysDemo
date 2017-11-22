//
//  BookModel.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/21.
//  Copyright © 2017年 Tang. All rights reserved.
//

import Foundation

class BookListModel {
    let bookName: String
    let bookImg: String
    let author: Array<String>
    let bookId: String
    init(_ dic: Dictionary<String, Any>) {
        self.bookImg = (dic["image"] as? String) ?? ""
        self.bookName = (dic["title"] as? String) ?? ""
        self.bookId = (dic["id"] as? String) ?? ""
        self.author = (dic["author"] as? Array<String>) ?? [""]
    }
}


class BookDetailModel {
    let bookName: String
    let bookImg: String
    let author: Array<String>
    let bookId: String
    let summary: String
    let publisher: String
    let price: String
    init(_ dic: Dictionary<String, Any>) {
        self.bookImg = (dic["image"] as? String) ?? ""
        self.bookName = (dic["title"] as? String) ?? ""
        self.bookId = (dic["id"] as? String) ?? ""
        self.author = (dic["author"] as? Array<String>) ?? [""]
        self.summary = (dic["summary"] as? String) ?? ""
        self.publisher = (dic["publisher"] as? String) ?? ""
        self.price = (dic["price"] as? String) ?? ""
    }
}
