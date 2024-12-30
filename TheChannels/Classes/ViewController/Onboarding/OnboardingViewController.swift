//
//  OnboardingViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 30/11/24.
//

import UIKit
import CHIPageControl

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControllerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
//    CHIPageControlJalapeno
//    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    internal let numberOfPages = 4
    var pageControl: CHIPageControlJaloro!

    
    var currentIndex = 0
    var onboardingDetails: [[String : Any]]?
    var intoImages = ["icintro_0", "icintro_1", "icintro_2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingDetails = getIntroTitles()
        setupCollectionView()
        setupUI()
    }
    
    func setupUI() {
        nextButton.layer.cornerRadius = 8
        let title = onboardingDetails?[currentIndex]["title"] as? String
        titleLabel.text = title
        
        
        // Initialize CHIPageControl
        pageControl = CHIPageControlJaloro(frame: CGRect(x: 0, y: 0, width: pageControllerView.frame.width, height: pageControllerView.frame.height))
        pageControl.numberOfPages = intoImages.count
        pageControl.radius = 4
        pageControl.tintColor = .lightGray
        pageControl.currentPageTintColor = .black
        pageControl.padding = 6
        
        // Add to the view
        pageControllerView.addSubview(pageControl)
    }
    
    func setupCollectionView() {
        
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.register(cell: Cell.onboardingCell)
        
        let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .horizontal // For horizontal scrolling
               layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Full screen size
               layout.minimumLineSpacing = 0 // No spacing between cells
            
        onboardingCollectionView.collectionViewLayout = layout
        onboardingCollectionView.isPagingEnabled = true // Enable paging
        onboardingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        onboardingCollectionView.isScrollEnabled = false
        onboardingCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func moveToNotificationVC() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.notificationPermissionVC) as? NotificationPermissionViewController {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "OnboardigComplete")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        if currentIndex != 2 {
            onboardingCollectionView.scrollToItem(at: IndexPath(item: currentIndex + 1, section: 0), at: .left, animated: false)
            currentIndex += 1
            pageControl.set(progress: currentIndex, animated: true)
            let title = onboardingDetails?[currentIndex]["title"] as? String
            titleLabel.text = title
        } else {
            moveToNotificationVC()
        }
    }
}

//    MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.onboardingCell, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        let imageName = onboardingDetails?[indexPath.item]["image"] as? String ?? ""
        cell.imageView.image = UIImage(named: imageName)
        return cell
    }
}
