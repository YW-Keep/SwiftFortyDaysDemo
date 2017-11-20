//
//  TableViewCellMoveController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/17.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TableViewCellMoveController: UIViewController {
    
    var dataArray = [String]()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 60

        // 自定义的方式， 主要思路是 在长按后 拿到cell的快照进行移动，做一个移动假象，最后进行数据交换
        view.addGestureRecognizer(gesture)
        return view;
    }()
    
    lazy var gesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = 0.5
        gesture.addTarget(self, action: #selector(processGesture(gesture:)))
        return gesture
    }()
    
    // 移动的假的cell
    var tempView: UIView?
    
    // 选中cell 的位置
    var selectorIndexPath: IndexPath?
    
    // 同步刷新定时器  为了实现在下拉过程中滚动
    var linkTimer: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "cell 移动"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.getData()
        // Do any additional setup after loading the view.
    }
    func getData() {
        dataArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    }
    deinit {
        print("页面释放")
    }

}
extension TableViewCellMoveController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RefreshCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "RefreshCell")
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = dataArray[indexPath.row] + ".我就是个测试的假数据忽略我"
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
    // 这是系统的方法，只要 tableView.setEditing(true, animated: true) 就可以开启了 但是无法做到长按移动，也只能在边上的的按钮点击移动
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return .none
//    }
//    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        print("数据测试")
//    }
    
}
// 实现拖动
extension TableViewCellMoveController {
    
    @objc private func processGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            gestureBegan(gesture)
//        case .changed:
//            gestureChanged(gesture)
        case .ended, .cancelled:
            getsureEnd(gesture)
        default: break
            
        }
    }
    
    private func gestureBegan(_ gesture: UILongPressGestureRecognizer) {
        // 拿到点击的cell的位置
        let point = gesture.location(in: gesture.view)
        let indexPath = tableView.indexPathForRow(at: point)
        guard indexPath != nil else {
            return
        }
        
        startScroll()
        
        selectorIndexPath = indexPath!
        let cell = tableView.cellForRow(at: indexPath!)
        tempView = generateSnapshot(cell!)
        
        //设置图片的效果
        tempView!.layer.shadowColor = UIColor.gray.cgColor
        tempView!.layer.masksToBounds = true
        tempView!.layer.shadowOffset = CGSize(width: -5, height: 0)
        tempView!.layer.shadowOpacity = 0.4
        tempView!.layer.shadowRadius = 5
        tempView!.frame = cell!.frame
        tableView.addSubview(tempView!)
        
        // 隐藏cell
        cell!.isHidden = true
        
        // 修改cell 中心位置
        UIView.animate(withDuration: 0.25) {
            self.tempView!.center = CGPoint(x: self.tempView!.center.x, y: point.y)
        }
    }
    
    private func gestureChanged(_ gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        let currentIndexPath = tableView.indexPathForRow(at: point)
        if currentIndexPath != nil && currentIndexPath != selectorIndexPath {
            // 交换数据源 与cell
             let cell = tableView.cellForRow(at: selectorIndexPath!)
            cell?.isHidden = true
            changeCellAndData(fromIndexpath: selectorIndexPath!, toIndexpath: currentIndexPath!)
           
            selectorIndexPath = currentIndexPath;
        }
        
        tempView?.center = CGPoint(x: (tempView?.center.x)!, y: point.y)
    }
    private func getsureEnd(_ gesture: UILongPressGestureRecognizer) {
         stopScroll()
        // 结束的时候放到相应的位置 然后影藏view
        let cell = tableView.cellForRow(at: selectorIndexPath!)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.tempView?.frame = cell!.frame
        }) { (_) in
            cell?.isHidden = false
            self.tempView?.removeFromSuperview()
            self.tempView = nil
        }
    }
    
    // 生成快照图片
    private func generateSnapshot(_ snapshotView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(snapshotView.bounds.size, false, 0)
        snapshotView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImageView(image: image)
    }
    
    private func changeCellAndData(fromIndexpath:IndexPath, toIndexpath:IndexPath) {
        // 简化处理 现在就一个section
        dataArray.swapAt(fromIndexpath.row, toIndexpath.row)
        tableView.moveRow(at: fromIndexpath, to: toIndexpath)
    }
    
    // 定时器相关
    private func startScroll() {
        linkTimer = CADisplayLink(target: self, selector: #selector(scrollProcess))
        linkTimer?.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    // 判别是不是在滚动区域如果是 就滚动
    @objc private func scrollProcess() {
        gestureChanged(gesture)
        let minOffsetY = tableView.contentOffset.y + 150
        let maxOffsetY = tableView.contentOffset.y + kScreenHeight - 150
        let touchPoint = tempView!.center
        if touchPoint.y < 150 && tableView.contentOffset.y <= 0 {
            return
        }
        if touchPoint.y >  tableView.contentSize.height - 150 && tableView.contentOffset.y  > tableView.contentSize.height - kScreenHeight {
            return
        }
       
        // 看间距，越大越快 乘了10倍 速度
        if touchPoint.y < minOffsetY {
            let maxMoveDistance = (minOffsetY - touchPoint.y)/150 * 10
            tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y - maxMoveDistance)
            tempView?.center = CGPoint(x: tempView!.center.x, y: tempView!.center.y - maxMoveDistance)
        } else if touchPoint.y > maxOffsetY {
            let maxMoveDistance = (touchPoint.y - maxOffsetY)/150 * 10
            tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y + maxMoveDistance)
            tempView?.center = CGPoint(x: tempView!.center.x, y: tempView!.center.y + maxMoveDistance)
        }
    }
    
    private func stopScroll() {
        if linkTimer != nil {
            linkTimer?.invalidate()
            linkTimer = nil
        }
    }
    
}
