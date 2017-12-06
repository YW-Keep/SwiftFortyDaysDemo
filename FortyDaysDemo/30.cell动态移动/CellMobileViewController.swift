//
//  CellMobileViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/12/4.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

// 如果是iOS9 之前 没有API 可以用实现UITableView拖动的方式拖动视图
class CellMobileViewController: UIViewController {
    
    lazy var conllectionView: UICollectionView =  {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize =  CGSize.init(width: 80, height: 30)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumLineSpacing = 10
        let inConllectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 100), collectionViewLayout: layout)
        inConllectionView.register(MobileCell.self, forCellWithReuseIdentifier: "MobileCell")
        inConllectionView.backgroundColor = UIColor.white
        inConllectionView.dataSource = self
        inConllectionView.delegate = self
        let longGestures = UILongPressGestureRecognizer(target: self, action: #selector(self.longGesturesAction(longGesture:)))
        inConllectionView.addGestureRecognizer(longGestures)
   
        return inConllectionView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: kScreenHeight - 80, width: 80, height: 30)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitle("添加", for: .normal)
        button.addTarget(self, action: #selector(self.addAction), for: .touchUpInside)
        return button
    }()
    
    lazy var showView: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: kScreenHeight - 80, width: 80, height: 30))
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    var isAddUpData = false
    
    var dataArray = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "cell移动"
        self.view.backgroundColor = .white
        self.view.addSubview(conllectionView)
        self.view.addSubview(addButton)
        getData()
    }
    
    func getData() {
        var inData = [String]()
        for index in 1...25 {
            inData.append(String(index))
        }
        dataArray = inData
        conllectionView.reloadData()
    }
    
    @objc func longGesturesAction(longGesture: UILongPressGestureRecognizer) {
        switch longGesture.state {
            // 系统一共提供了四种cell移动的方法  下面是三种还有个取消
            //conllectionView.cancelInteractiveMovement()
        case .began:
            if let indexPath = conllectionView.indexPathForItem(at: longGesture.location(in: conllectionView)) {
                self.conllectionView.beginInteractiveMovementForItem(at: indexPath)
            }
        case .changed:
            conllectionView.updateInteractiveMovementTargetPosition( longGesture.location(in: conllectionView))
        case .ended:
            conllectionView.endInteractiveMovement()
        default:
            conllectionView.endInteractiveMovement()
        }
    }
    
    @objc func addAction() {
        
        if isAddUpData {
            return
        }
        
        dataArray.append(String(dataArray.count + 1))
        isAddUpData = true
        conllectionView.reloadData()
        
        DispatchQueue.main.async {
            var y = self.conllectionView.contentSize.height - self.conllectionView.frame.height
            y = y < -64 ? -64 : y
            self.conllectionView.setContentOffset( CGPoint(x: 0, y: y), animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                if let cell =  self.conllectionView.cellForItem(at: IndexPath(row: self.dataArray.count - 1, section: 0)) as? MobileCell {
                    var rect = cell.frame
                    rect.origin.y = cell.frame.origin.y - self.conllectionView.contentOffset.y
                    self.showView.text = String(self.dataArray.count)
                    self.showView.frame = CGRect(x: 100, y: kScreenHeight - 80, width: 80, height: 30)
                    self.view.addSubview(self.showView)
                    UIView.animate(withDuration: 0.5, animations: {
                        self.showView.frame = rect
                    }, completion: { (_) in
                        cell.titleLabel.backgroundColor = .lightGray
                        self.showView.removeFromSuperview()
                        self.isAddUpData = false
                    })
                    
                }
            }
        }
    }
    
}

extension CellMobileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MobileCell", for: indexPath) as! MobileCell
        cell.titleLabel.text = dataArray[indexPath.row]
        if isAddUpData && indexPath.row == (dataArray.count - 1){
            cell.titleLabel.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 移动结束后调用 交换数据
        let string = dataArray[sourceIndexPath.row]
        dataArray.remove(at: sourceIndexPath.row)
        dataArray.insert(string, at: destinationIndexPath.row)
    }
}
