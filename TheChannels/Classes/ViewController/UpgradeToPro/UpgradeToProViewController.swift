//
//  UpgradeToProViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 12/12/24.
//

import UIKit

enum PriceType: String, CaseIterable {
    case week = "Week"
    case month = "Month"
    case yearl = "Yearl"
}


// MARK: - FAQCell

class FAQCell: UITableViewCell {
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - StoreReviewCell

class StoreReviewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var storeReviewTitle: UILabel!
    @IBOutlet weak var storeReviewDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 8
    }
    
}

// MARK: - PriceCell

class PriceCell: UITableViewCell {
    
    @IBOutlet weak var freeTrialText: UILabel!
    @IBOutlet weak var freeTrialView: UIView!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var amountPerWeekLabel: UILabel!
    @IBOutlet weak var amountPerType: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 8
        freeTrialView.layer.cornerRadius = 8
        freeTrialView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]

    }
    
}

// MARK: - HeaderTitleCell

class HeaderTitleCell: UITableViewCell {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var emojiImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - OﬀerCell

class OﬀerCell: UITableViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 8 
    }
    
}

// MARK: - LabelCell

class LabelCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

// MARK: - FeatureHeaderCell

class FeatureHeaderCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

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
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0
            
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true // Enable paging
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        pageController.currentPage = 0
        pageController.numberOfPages = 4
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate the current page
        let pageWidth = scrollView.bounds.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageController.currentPage = currentPage
    }
    
}

//    MARK: - FeatureListCell:  UICollectionViewDelegate, UICollectionViewDataSource

extension FeatureListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // introImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.onboardingCell, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: "iccnpremiumbanner")
        return cell
    }
}

// MARK: - UpgradeToProViewController

class UpgradeToProViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var inAppOffers: [[String: Any]]?
    var offerCellSubTitle: [String] = ["it's actuall 20% off discounted price.", "You can cancle any time from the App Store", "For 1-month and the make up your mind."]
    var priceType = PriceType.allCases
    var inAppProducts: [[String: Any]]?
    var selectedIndex: Int? = 0
    var faqs: [FAQsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        getdata()
    }
    
    func getdata() {
        inAppOffers = getInAppOffers()
        faqs = getFAQList()
        inAppProducts = getInAppProducts()
        tableView.reloadData()
    }
    
    func setupUI() {
        continueButton.layer.cornerRadius = 8
        bottomView.layer.cornerRadius = 25
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }

//    MARK: - Button Action
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func termsAction(_ sender: UIButton) {
        openURL(link: AppConfigs.kAppTermsURL)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
    }
    
    @IBAction func privacyAction(_ sender: UIButton) {
        openURL(link: AppConfigs.kAppPrivacyPolicyURL)
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
    }
    
}

// MARK: - UpgradeToProViewController: UITableViewDelegate, UITableViewDataSource

extension UpgradeToProViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureListCell", for: indexPath) as? FeatureListCell {
                return cell
            }

        } else if indexPath.row == 1 {
            return UITableViewCell()

        } else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureHeaderCell", for: indexPath) as? FeatureHeaderCell {
                return cell
            }

        } else if indexPath.row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? LabelCell {
                return cell
            }

        } else if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OﬀerCell", for: indexPath) as? OﬀerCell {
                let currentIndex = indexPath.row - 4
                let title = inAppOffers?[currentIndex]["title"] as? String
                let subTitle = inAppOffers?[currentIndex]["subtitle"] as? String
                let emojiLabel = inAppOffers?[currentIndex]["emoji"] as? String

                cell.titleLabel.text = title
                cell.descLabel.text = subTitle
                cell.emojiLabel.text = emojiLabel

                return cell
            }

        } else if indexPath.row == 7 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTitleCell", for: indexPath) as? HeaderTitleCell {
                cell.headerTitleLabel.text = "Unlock Everything"
                return cell
            }

        } else if indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as? PriceCell {
                let currentIndex = indexPath.row - 8
                
                let duraction = inAppProducts?[currentIndex]["duration"] as? String
                let weekprice = inAppProducts?[currentIndex]["weekprice"] as? String
                let price = inAppProducts?[currentIndex]["price"] as? String
                let discount = inAppProducts?[currentIndex]["discount"] as? String
                let bannerbadge = inAppProducts?[currentIndex]["bannerbadge"] as? String
                
                if bannerbadge != "" {
                    cell.freeTrialView.isHidden = false
                    cell.freeTrialText.text = bannerbadge
                } else {
                    cell.freeTrialView.isHidden = true
                }
                if bannerbadge != "" {
                    cell.saveLabel.isHidden = false
                    cell.saveLabel.text = discount
                } else {
                    cell.saveLabel.isHidden = true
                }
                
                cell.typeLabel.text = duraction
                cell.amountPerType.text = price
                cell.amountPerWeekLabel.text = weekprice
                
                if selectedIndex == indexPath.row {
                    cell.mainView.layer.borderColor = UIColor.blue.cgColor
                    cell.mainView.layer.borderWidth = 1
                    cell.mainView.backgroundColor = UIColor(red: 228/255, green: 239/255, blue: 253/255, alpha: 1) // .yellow
                } else {
                    cell.mainView.layer.borderWidth = 0
                    cell.mainView.backgroundColor = .white
                }
                
                return cell
            }
        } else if indexPath.row == 11 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTitleCell", for: indexPath) as? HeaderTitleCell {
                cell.headerTitleLabel.text = "What Our Users Says :"
                return cell
            }

        } else if indexPath.row == 12 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReviewCell", for: indexPath) as? StoreReviewCell {
                cell.storeReviewTitle.text = "Quick Messages are soo helpful!"
                cell.storeReviewDescLabel.text = "I use them for most replies to all my clients! Saving me tons of time. Plus, they're super easy to create, Love it!"
                return cell
            }
        } else if indexPath.row == 13 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTitleCell", for: indexPath) as? HeaderTitleCell {
                cell.headerTitleLabel.text = "FAQs"
                return cell
            }

        } else if indexPath.row == 14 || indexPath.row == 15 || indexPath.row == 16 || indexPath.row == 17 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as? FAQCell {
                let currentIndex = indexPath.row - 14
                cell.questionLabel.text = faqs[currentIndex].question
                if faqs[currentIndex].isOpen {
                    cell.answerLabel.text = faqs[currentIndex].answer
                    cell.answerLabel.isHidden = false
                    cell.arrowImage.image = UIImage(named   : "iccndropdownup")
                    } else {
                    cell.arrowImage.image = UIImage(named: "iccndropdown")
                    cell.answerLabel.isHidden = true
                }
                return cell
            }
        } else {
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        if (14...17).contains(selectedIndex ?? 0) { // FAQ
            let number = (selectedIndex ?? 0) - 14
            faqs[number].isOpen = !faqs[number].isOpen
        } else if (8...10).contains(selectedIndex ?? 0) { //        PriceCell
            if selectedIndex == 8 {
                continueButton.setTitle("Tryit Free", for: .normal)
            } else {
                continueButton.setTitle("Continue", for: .normal)
            }
        } else {

        }
        
        tableView.reloadData()
    }

}
