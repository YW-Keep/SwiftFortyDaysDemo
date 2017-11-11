//
//  FriendsMessageModel.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/10.
//  Copyright © 2017年 Tang. All rights reserved.
//

import Foundation
class FriendsMessage {
    var messageName: String
    var messageIcon: String
    var messageContent: String
    var messageImages : [String]
    init(messageName: String, messageIcon: String, messageContent: String, messageImages : [String]) {
        self.messageName = messageName
        self.messageIcon = messageIcon
        self.messageContent = messageContent
        self.messageImages = messageImages
    }
}
