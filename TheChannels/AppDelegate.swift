//
//  AppDelegate.swift
//  TheChannels
//
//  Created by Shilp on 29/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setStoryboard()
        return true
    }

    func setStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - AppDelegate Instance
    class var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    

}

