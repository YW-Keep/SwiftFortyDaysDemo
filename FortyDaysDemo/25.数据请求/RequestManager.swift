//
//  RequestManager.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/21.
//  Copyright © 2017年 Tang. All rights reserved.
//

import Foundation
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
}
