//
//  SearchBookViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/21.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class SearchBookViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [BookListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索图书"
        tablviewInit()
//        let url =  URL(string: "https://api.douban.com/v2/book/1220562")
//        let session = URLSession.shared
//        var task = session.dataTask(with: url!) { (data, response, error) in
//            if error == nil {
//                let dic =  try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
//                print(dic ?? "")
//                print(response ?? "")
//            }
//        }
//        task.resume()

        // Do any additional setup after loading the view.
    }
    func tablviewInit() {
        tableView.rowHeight = 100
        let nib = UINib(nibName: "BookListCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        tableView.register(nib, forCellReuseIdentifier: "BookListCell")
        
    }
    
    // 点击搜索按钮
    @IBAction func searchAction(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        guard searchTextField.text?.count ?? 0 > 0 else {
            print("输入内容需有啦")
            return
        }
        Request.requestBookList(searchString: searchTextField.text!) { (models) in
            self.dataArray = models
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         searchTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchBookViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookListCell = tableView.dequeueReusableCell(withIdentifier: "BookListCell") as! BookListCell
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = BookDetailViewController()
        detailVC.bookId = dataArray[indexPath.row].bookId
        self.show(detailVC, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
