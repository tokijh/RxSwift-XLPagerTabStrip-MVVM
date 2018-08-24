//
//  AppDelegate.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import RxSwiftExtensions

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    // MARK Window
    public var window: UIWindow?
    public lazy var navigationController: UINavigationController = UINavigationController(rootViewController: self.rootViewController)
    public lazy var rootViewController: UIViewController = MainViewController()
    
    fileprivate func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white // Set default background color
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

