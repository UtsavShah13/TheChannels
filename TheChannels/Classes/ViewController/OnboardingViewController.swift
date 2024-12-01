//
//  OnboardingViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 30/11/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func moveToHomeVC() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.homeVC) as? HomeViewController {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "OnboardigComplete")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        moveToHomeVC()
    }
}
