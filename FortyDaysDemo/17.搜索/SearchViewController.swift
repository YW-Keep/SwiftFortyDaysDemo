//
//  SearchViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/8.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import CoreSpotlight
/*
 搜索包含两个部分组成。
 1.通过Core Spotlight（属于 Search APIs）完成在手机外部搜索跳转到APP的过程
 2.内部通过searchVC 完成列表搜索
 */
class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController:UISearchController!
    
    var remberArray: [(image: String, title: String, content: String)] = []
    var dataArray: [(image: String, title: String, content: String)] = []
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        view.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 80
        return view;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        addButton()
        getData()
        configureSearchController()
        addDataForSearch()
        // Do any additional setup after loading the view.
    }
    
    //  添加右边的添加按钮
    func addButton() {
        let button = UIButton(type: .detailDisclosure)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action:#selector(deleteAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    // 模拟获取数据
    func getData() {
        dataArray = [("gastronomy1","菠萝饼","这东西看上去好吃啊"),("gastronomy2","煎虾仁","这个也不错"),("gastronomy3","红烧肉","晚上看这个会饿啊"),("gastronomy4","羊肉串","都好吃，都好吃"),("gastronomy5","芝士大虾","哈哈哈哈哈"),("gastronomy6","香炒老豆腐","我实在是编不下去了,我实在是编不下去了,我实在是编不下去了")]
        remberArray = dataArray
    }
    
    // 添加数据
    func addDataForSearch() {
        
        // iOS 9之前木有
        guard #available(iOS 9.0, *) else  {
            return
        }
        
        var addArray: [CSSearchableItem] = []
        var num: Int = 0
        for data in dataArray {
            let searchItemAtr = CSSearchableItemAttributeSet(itemContentType: "eatType")
            searchItemAtr.title = data.title
            searchItemAtr.contentDescription = data.content
            let path  = Bundle.main.path(forResource: data.image, ofType: "jpg")
            searchItemAtr.thumbnailData = UIImagePNGRepresentation(UIImage(contentsOfFile: path!)!)
            searchItemAtr.contactKeywords = ["美食","好吃","测试"]
            //UniqueIdentifier每个搜索都有一个唯一标示，当用户点击搜索到得某个内容的时候，系统会调用代理方法，会将这个唯一标示传给你，以便让你确定是点击了哪一，方便做页面跳转
            //domainIdentifier搜索域标识，删除条目的时候调用的delegate会传过来这个值
            let searchItem = CSSearchableItem(uniqueIdentifier: String(num), domainIdentifier: data.content, attributeSet: searchItemAtr)
            addArray.append(searchItem)
            num += 1
        }
        let searchIndex = CSSearchableIndex.default()
        searchIndex.indexSearchableItems(addArray) { (error) in
            if error == nil {
                print("加载成功")
            } else {
                print("加载失败")
            }
       }
    }
    
    @objc func deleteAction() {
        let searchIndex = CSSearchableIndex.default()
        searchIndex.deleteAllSearchableItems { (error) in
            if error == nil {
                print("删除成功")
            } else {
                print("删除失败")
            }
        }
    }
    // MARK: - UISearchController
    func configureSearchController(){
        
        searchController = UISearchController(searchResultsController:nil)
        searchController.searchResultsUpdater = self
        // 页面变黑
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false;
  
      
        // 搜索
        searchController.searchBar.placeholder = "搜索内容"
        searchController.searchBar.delegate = self
        
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        // 不设置这个属性 searchController 不关闭
        self.definesPresentationContext = true
    }
    // UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text!
        dataArray = remberArray
        if searchString.count > 0 {
            // 数组帅选
            dataArray = dataArray.filter({ (data) -> Bool in
                let  titleHave =  data.title.contains(searchString)
                let contentHave = data.content.contains(searchString)
                return (titleHave || contentHave)
            })
        }
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.data = dataArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  col =  SearchDetailViewController.init(data: dataArray[indexPath.row])
        self.show(col, sender: nil)
    }

}
