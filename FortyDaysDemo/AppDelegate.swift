//
//  AppDelegate.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/18.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        //  判断应用的启动是否是因为用户选择了Home Screen Quick Actions选项
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            // 这里可以进行在未启动时的处理
            print(shortcutItem.type)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        // Home Screen Quick Actions 在这里写处理方法哦 这里需要在应用已被启动后调用
        print(shortcutItem.type)
    }
    
    // 这里是搜索的回调哦
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        let nav = self.window?.rootViewController
        let num = userActivity.userInfo!["kCSSearchableItemActivityIdentifier"]! as! String
        
       let array = [("gastronomy1","菠萝饼","这东西看上去好吃啊"),("gastronomy2","煎虾仁","这个也不错"),("gastronomy3","红烧肉","晚上看这个会饿啊"),("gastronomy4","羊肉串","都好吃，都好吃"),("gastronomy5","芝士大虾","哈哈哈哈哈"),("gastronomy6","香炒老豆腐","我实在是编不下去了,我实在是编不下去了,我实在是编不下去了")]
        
        let col = SearchDetailViewController(data: array[Int(num)!])
        nav?.show(col, sender: nil)
        
        return true
    }
}

