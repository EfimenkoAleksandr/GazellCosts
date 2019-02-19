//
//  AppDelegate.swift
//  GazelleCosts
//
//  Created by mac on 11.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().tintColor = UIColor.black
        
        //UINavigationBar.appearance().backgroundColor = UIColor.black
        //UINavigationBar.appearance()

        
//        let statusBarBackgroundView = UIView()
//        statusBarBackgroundView.backgroundColor = UIColor.green
//        statusBarBackgroundView.frame = CGRect(x: 0, y: 0, width: (window?.frame.width)!, height: 20)
//
//        window?.addSubview(statusBarBackgroundView)
//        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//
//        let myConstraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": statusBarBackgroundView])
//        let myConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": statusBarBackgroundView])
//        NSLayoutConstraint.activate(myConstraint1)
//        NSLayoutConstraint.activate(myConstraint2)
        
        //let myLabelhorizontalConstraint = NSLayoutConstraint(item: statusBarBackgroundView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: statusBarBackgroundView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //let myLabelverticalConstraint = NSLayoutConstraint(item: statusBarBackgroundView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: statusBarBackgroundView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "xMAtMA2HIhnKAmkAjG04EvV0i8jKljLc7dPae5SW"
            $0.clientKey = "5RJF9W1dtIiCLMNzDS3XMOUYq4XGlUrXUmVFkxKw"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        
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
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.sharedManager.saveContext()
    }

}

