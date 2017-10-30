//
//  CardScrollCell.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/10/29.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
/*
 构造器知识点
 指定构造器必须调用其直接父类的的指定构造器。
 便利构造器必须调用同类中定义的其它构造器。
 便利构造器必须最终导致一个指定构造器被调用。
 简单的说就是：
 指定构造器必须总是向上代理
 便利构造器必须总是横向代理
 
 两段式构造过程
 
 Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
 
 两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
 阶段 1
 某个指定构造器或便利构造器被调用。
 完成新实例内存的分配，但此时内存还没有被初始化。
 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
 指定构造器将调用父类的构造器，完成父类属性的初始化。
 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
 
 阶段 2
 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
 最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。
 
 构造器的继承：Swift 中的子类默认情况下不会继承父类的构造器，仅会在安全和适当的情况下被继承。继承规则如下：
 规则 1
 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
 
 规则 2
 如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
 
 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
 
 
 init? 即为可以失败的构造器
 required 为必要构造器，即所有子类必须重写该该构造器，不需要添加override
 
 */
class CardScrollCell: UICollectionViewCell {
    var imgView: UIImageView?
    var titleLabel: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 添加imgView
        self.imgView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: (frame.height - 40)))
        self.imgView?.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(self.imgView!)
        
        // 添加Label
        self.titleLabel = UILabel(frame:CGRect.init(x: 20, y: (frame.height - 40), width: (frame.width - 40), height: 40))
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.textColor = UIColor.white
        self.addSubview(self.titleLabel!)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
