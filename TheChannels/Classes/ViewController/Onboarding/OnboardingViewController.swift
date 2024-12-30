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
    @IBOutlet weak var nextButton: UIButton!

    var pageControl: CHIPageControlJaloro!
    var currentIndex = 0
    var onboardingDetails: [[String : Any]]?
    
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
        pageControl.numberOfPages = onboardingDetails?.count ?? 0
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
    
    func updateUIForCurrentIndex() {
        // Update the title label
        let title = onboardingDetails?[currentIndex]["title"] as? String
        titleLabel.text = title

        pageControl.set(progress: currentIndex, animated: true)

        print("UI updated for index:", currentIndex, "Title:", title ?? "No title")
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        if currentIndex != 2 {
            currentIndex += 1
            
            // Disable user interaction during programmatic scroll
            onboardingCollectionView.isPagingEnabled = false
            onboardingCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)

            // Re-enable after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.onboardingCollectionView.isPagingEnabled = true
            }
            
            updateUIForCurrentIndex()
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: onboardingCollectionView.contentOffset, size: onboardingCollectionView.bounds.size)
        if let visibleIndexPath = onboardingCollectionView.indexPathForItem(at: CGPoint(x: visibleRect.midX, y: visibleRect.midY)) {
            currentIndex = visibleIndexPath.item
            updateUIForCurrentIndex()
        }
    }

}
