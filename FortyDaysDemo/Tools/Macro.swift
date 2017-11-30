//
//  Macro.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width

let iPhone_X = (kScreenWidth == 375 && kScreenHeight == 812 ? true : false)
let NavigationBarHeight: CGFloat = (iPhone_X ? 88 : 64)
