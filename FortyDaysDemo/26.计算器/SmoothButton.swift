//
//  smoothButton.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/24.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class SmoothButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        becomeSmooth()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeSmooth()
    }
    
    private func becomeSmooth() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.masksToBounds = true
    }

}

class OperatorButton: SmoothButton {
    
    override var isSelected: Bool {
        didSet{
            let orangeColor = UIColor(red: 249/255.0, green: 161/255.0, blue: 0, alpha: 1)
            self.backgroundColor = isSelected ? .white : orangeColor
        }
    }
}
