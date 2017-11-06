//
//  CoreDataViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/6.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import CoreData
/*
 CoreData 是苹果在iOS3 推出的一个数据存储框架，它主要提供了一种对象关系映射的存储关系。
 就是说它可以把数据库中的数据转化为对象，也可以把对象储存到数据库中，不需要使用SQL语句。
  CoreData本质上是对SQLite的一个封装，在内部将对象的持久化转化为SQL语句执行
 CoreData 简单的创建流程：
 1.模型文件操作
    1.1 创建模型文件，后缀名为.xcdatamodeld。创建模型文件之后，可以在其内部进行添加实体等操作(用于表示数据库文件的数据结构)
    1.2 添加实体(表示数据库文件中的表结构)，添加实体后需要通过实体，来创建托管对象类文件。
    1.3 添加属性并设置类型，可以在属性的右侧面板中设置默认值等选项。(每种数据类型设置选项是不同的)
    1.4 创建获取请求模板、设置配置模板等。
    1.5 根据指定实体，创建托管对象类文件(基于NSManagedObject的类文件)
 
 2.实例化上下文对象
     2.1 创建托管对象上下文(NSManagedObjectContext)
     2.2 创建托管对象模型(NSManagedObjectModel)
     2.3 根据托管对象模型，创建持久化存储协调器(NSPersistentStoreCoordinator)
     2.4 关联并创建本地数据库文件，并返回持久化存储对象(NSPersistentStore)
     2.5 将持久化存储协调器赋值给托管对象上下文，完成基本创建。
 */
class CoreDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 获取这个model的管理对象
    lazy var coreDataStack = CoreDataStack(modelName: "Model")
    
    var dataArry: [UserInfo] = []
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 40
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CoreData"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        self.addButton()
        self.addData()
        // Do any additional setup after loading the view.
        
    }
    
    //  添加右边的添加按钮
    func addButton() {
        let button = UIButton(type: .contactAdd)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action:#selector(showAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func showAction() {
        let alertCol = UIAlertController(title: "请添加一个新名字",
                                      message: "",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "保存", style: .default) { (_) in
            if let textField = alertCol.textFields?.first {
                self.addCoreData(name: textField.text!)
                self.tableView.reloadData()
                
            }
        }
        let cancelAction = UIAlertAction(title: "取消",
                                         style: .default)
        alertCol.addTextField()
        alertCol.addAction(saveAction)
        alertCol.addAction(cancelAction)
        present(alertCol, animated: true)
        
    }
    
    func addCoreData(name: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: coreDataStack.managedContext)
        let item: UserInfo = NSManagedObject(entity: entity!, insertInto: coreDataStack.managedContext) as! UserInfo
        item.name = name
        coreDataStack.saveContext()
        dataArry.append(item)
    }
    
    func addData() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
        do {
            dataArry = try coreDataStack.managedContext.fetch(fetchRequest) as! [UserInfo]
            tableView.reloadData()
        } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RefreshCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "RefreshCell")
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = dataArry[indexPath.row].name
        return cell!
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
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let  delect = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "删除") { (rowAction, indexPath) in
        self.coreDataStack.managedContext.delete(self.dataArry[indexPath.row])
            self.coreDataStack.saveContext()
            self.dataArry.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            
        }
        return [delect]
    }
}
