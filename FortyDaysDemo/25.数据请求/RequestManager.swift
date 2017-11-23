//
//  RequestManager.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/21.
//  Copyright © 2017年 Tang. All rights reserved.
//

import Foundation
import Alamofire

// 这里写了两套网络请求的方式，一套用原生的 一套用了Alamofire 这里用pod导入了第三方 好像与OC区别不大
class Request {
    class func requestBookList(searchString: String, complete: @escaping ([BookListModel]) -> Void) {
        let session = URLSession.shared
        let urlString = "https://api.douban.com/v2/book/search?q=\(searchString)"
        let searchURL = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)
        let request = URLRequest(url: searchURL!)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                let dic =  try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                let books = dic!["books"] as! [Any]
                var listBook = Array<BookListModel>()
                
                for book in books {
                    if ((book as? Dictionary<String, Any>) != nil) {
                        listBook.append(BookListModel(book as! Dictionary<String, AnyObject>))
                    }
                }
                complete(listBook)
            }
        })
        task.resume()
    }
    
    class func requestBookDetail(bookId: String, complete: @escaping (BookDetailModel) -> Void) {
        let session = URLSession.shared
        let urlString = "https://api.douban.com/v2/book/\(bookId)"
        let searchURL = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)
        let request = URLRequest(url: searchURL!)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                let dic =  try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                let model = BookDetailModel(dic ?? [:])
                complete(model)
            }
        })
        task.resume()
    }
    
    // 使用Alamofire 写的简单请求下同
    class func requestBookListNew(searchString: String, complete: @escaping ([BookListModel]) -> Void) {
        var urlString = "https://api.douban.com/v2/book/search?q=\(searchString)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!

        Alamofire.request(urlString).responseJSON { (response) in
            if response.result.isSuccess {
                let inDic = response.result.value as! [String: Any]
                let books = inDic["books"] as! [Any]
                var listBook = Array<BookListModel>()
                
                for book in books {
                    if ((book as? Dictionary<String, Any>) != nil) {
                        listBook.append(BookListModel(book as! Dictionary<String, AnyObject>))
                    }
                }
                complete(listBook)
            } else {
               complete([])
            }
        }
    }
    
    class func requestBookDetailNew(bookId: String, complete: @escaping (BookDetailModel) -> Void) {
        var urlString = "https://api.douban.com/v2/book/\(bookId)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
        Alamofire.request(urlString).responseJSON { (response) in
            if response.result.isSuccess {
                let inDic = response.result.value as! [String: Any]
                let model = BookDetailModel(inDic)
                complete(model)
            }
        }
    }

}
