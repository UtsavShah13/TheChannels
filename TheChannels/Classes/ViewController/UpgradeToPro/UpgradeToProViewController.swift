//
//  UpgradeToProViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 12/12/24.
//

import UIKit

// MARK: - FeatureListCell

class FeatureListCell: UITableViewCell {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: Cell.onboardingCell)
        
        let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .horizontal // For horizontal scrolling
               layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Full screen size
               layout.minimumLineSpacing = 0 // No spacing between cells
            
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true // Enable paging
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        pageController.currentPage = 0
        pageController.numberOfPages = 4
    }
    
}

//    MARK: - FeatureListCell:  UICollectionViewDelegate, UICollectionViewDataSource

extension FeatureListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // intoImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.onboardingCell, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: "iccnpremiumbanner")
        return cell
    }
}

// MARK: - UpgradeToProViewController

class UpgradeToProViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    func setupUI() {
        continueButton.layer.cornerRadius = 8
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.reloadData()
    }
    

//    MARK: - Button Action
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func termsAction(_ sender: UIButton) {
    }
    @IBAction func restoreAction(_ sender: UIButton) {
    }
    @IBAction func privacyAction(_ sender: UIButton) {
    }
    @IBAction func continueAction(_ sender: UIButton) {
    }
}

// MARK: - UpgradeToProViewController: UITableViewDelegate, UITableViewDataSource
extension UpgradeToProViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureListCell", for: indexPath) as? FeatureListCell {
                return cell
            }

        } else if indexPath.row == 1 {
            return UITableViewCell()

        } else if indexPath.row == 2 {
            return UITableViewCell()

        } else {
            return UITableViewCell()

        }
        return UITableViewCell()
    }
}
