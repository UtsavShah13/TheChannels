//
//  NotificationPermissionViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 07/12/24.
//

import UIKit

class NotificationPermissionViewController: UIViewController {

    @IBOutlet weak var stayUpdateView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        stayUpdateView.layer.cornerRadius = 8
    }
    
    private func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    
    func moveToHomeVC() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.homeVC) as? HomeViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func maybeLaterAction(_ sender: UIButton) {
        moveToHomeVC()
    }
    
    @IBAction func stayUpdateAction(_ sender: UIButton) {
        // Request notification permission
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                        return
                    }
                    
                    if granted {
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(true, forKey: "NotificationGranted")

                        self.moveToHomeVC()
                    } else {
                        self.showAlert(title: "Permission Denied", message: "You can enable notifications in Settings.")
                    }
                }
            }
        
    }
}
