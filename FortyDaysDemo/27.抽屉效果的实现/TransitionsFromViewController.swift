//
//  TransitionsFromViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/28.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TransitionsFromViewController: UIViewController {
    let transitionDelegate = TransitionManager()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 200
        view.register(TransitionsFromCell.self, forCellReuseIdentifier: "TransitionsFromCell")
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "转场动画"
        self.view.addSubview(tableView)
        self.addButton()
        // Do any additional setup after loading the view.
    }
    
    //  添加右边的添加按钮
    func addButton() {
        let button = UIButton(type: .detailDisclosure)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action:#selector(showAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func showAction() {

        let col = TransitionsToViewController()
        col.view.backgroundColor = UIColor.white
        col.transitioningDelegate = transitionDelegate
        col.modalPresentationStyle = .custom
        
        self.present(col, animated: true, completion: nil)
    }
    
}

extension TransitionsFromViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransitionsFromCell = tableView.dequeueReusableCell(withIdentifier: "TransitionsFromCell") as! TransitionsFromCell
        let imageName = "petPicture" + String(indexPath.row%10)
        cell.showImageView.image = UIImage(named: imageName)
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
        return 0.1
    }
}
