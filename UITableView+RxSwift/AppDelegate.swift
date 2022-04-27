//
//  AppDelegate.swift
//  UITableView+RxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = UIStoryboard(name: "<#StoryboardName#>", bundle: nil).instantiateInitialViewController() as! <#ViewControllerName#>
//        let navigationController = UINavigationController(rootViewController: vc)
//        self.window?.rootViewController = navigationController
//        self.window?.rootViewController = TableViewController()
        self.window?.rootViewController = CollectionViewController()
        self.window?.makeKeyAndVisible()
        return true
    }
}

