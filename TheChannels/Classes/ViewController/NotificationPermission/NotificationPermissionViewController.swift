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
    
    func moveToHomeVC() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.homeVC) as? HomeViewController {
            let userDefaults = UserDefaults.standard
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func maybeLaterAction(_ sender: UIButton) {
        moveToHomeVC()
    }
    
    @IBAction func stayUpdateAction(_ sender: UIButton) {
        moveToHomeVC()
    }
}
