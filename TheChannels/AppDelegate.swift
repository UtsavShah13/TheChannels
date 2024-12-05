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
    let userDefaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setMainStoryBoard()
        return true
    }

    func setMainStoryBoard() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigate = UINavigationController()
        navigate.isNavigationBarHidden = true
        
        let mainStoryBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        
        if userDefaults.bool(forKey: "OnboardigComplete") {
            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: Controller.homeVC) as? HomeViewController ?? HomeViewController()
            // Push the vcw  to the navigat
            navigate.pushViewController(homeVC, animated: false)
            // Set the window’s root view controller
            self.window!.rootViewController = navigate
            // Present the window
            self.window!.makeKeyAndVisible()

        } else {
            let optionVC = mainStoryBoard.instantiateViewController(withIdentifier: Controller.onboardingVC) as? OnboardingViewController ?? OnboardingViewController()
            // Push the vcw  to the navigat
            navigate.pushViewController(optionVC, animated: false)
            // Set the window’s root view controller
            self.window!.rootViewController = navigate
            // Present the window
            self.window!.makeKeyAndVisible()

        }

        
        
        
    }
    // MARK: - AppDelegate Instance
    class var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    

}

