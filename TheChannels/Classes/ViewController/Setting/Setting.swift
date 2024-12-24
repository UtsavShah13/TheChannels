//
//  SettingViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 29/11/24.
//

import UIKit
import SDWebImage

// MARK: - UpgradeToPremiumImageCell

class UpgradeToPremiumImageCell: UITableViewCell {

    @IBOutlet weak var tryFreeButton: UIButton!
    @IBOutlet weak var premiumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        premiumImageView.layer.cornerRadius = 8
        tryFreeButton.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func tryFreeAction(_ sender: UIButton) {
    }
    
}

// MARK: - MoreAppCollectionCell

class MoreAppCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appImageView.layer.cornerRadius = 18
    }
}

// MARK: - MoreAppCell

class MoreAppCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var appCollectionView: UICollectionView!
    @IBOutlet weak var selectedAppLabel: UILabel!
    @IBOutlet weak var installButton: UIButton!
    
    var moreApps: [[String : String]] = []
    var currentSelectedApp: [String : String] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        moreApps = getMoreApps()
        moreApps.append([:])
        moreApps.insert([:], at: 0)
        appCollectionView.reloadData()
        DispatchQueue.main.async {
             let indexPath = IndexPath(item: 2, section: 0)
             self.appCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            self.updateCenteredAppName()
         }
    }
    
    func setup() {
        installButton.layer.cornerRadius = 8
        appCollectionView.delegate = self
        appCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 30  // Vertical spacing between rows
//        layout.minimumInteritemSpacing = 25 // Horizontal spacing between cells
        layout.scrollDirection = .horizontal
        appCollectionView.showsHorizontalScrollIndicator = false
        appCollectionView.collectionViewLayout = layout
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCenteredAppName()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateCenteredAppName()
        }
    }

    func updateCenteredAppName() {
        // Calculate center point of the collection view
        let centerPoint = CGPoint(x: appCollectionView.contentOffset.x + (appCollectionView.frame.size.width / 2),
                                  y: appCollectionView.frame.size.height / 2)

        // Find the indexPath of the cell at the center point
        if let indexPath = appCollectionView.indexPathForItem(at: centerPoint) {
            currentSelectedApp = moreApps[indexPath.row]
            if let appName = currentSelectedApp["apptitle"] {
                selectedAppLabel.text = appName
            } else {
                selectedAppLabel.text = ""
            }
        }
    }
    
    func openURL(urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL or cannot open URL")
        }
    }

    @IBAction func installButtonAction(_ sender: UIButton) {
        openURL(urlString: currentSelectedApp["appurl"] ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreAppCollectionCell", for: indexPath) as? MoreAppCollectionCell {
            let imageUrl = URL(string: moreApps[indexPath.row]["appimage"] ?? "")
            cell.appImageView.sd_setImage(with: imageUrl)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 80, height: 80)
    }
}

// MARK: - SettingOptionCell

class SettingOptionCell: UITableViewCell {

    @IBOutlet weak var imageParentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageParentView.layer.cornerRadius = 8
    }
    
}

// MARK: - SettingViewController

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var settingHeaders = ["", "More APPS", "SPREAD LOVE", "LEGAL"]
    var spreadLoveTitles = ["Rate Us", "Share App", "Help"]
    var legalTitles = ["Privacy Policy", "Terms of use"]
    var spreadLoveIcons = ["iccnrateus", "arrowshape.turn.up.right.fill", "hand.thumbsup.fill"]
    var legalIcons = ["hand.raised.fingers.spread.fill", "list.bullet.clipboard.fill"]
    
    var spreadLoveBGColor: [UIColor] = [UIColor.colorFromHex("EAEAEA", alpha: 1) ?? .white,UIColor.colorFromHex("F9A904", alpha: 1) ?? .yellow,UIColor.colorFromHex("7616FE", alpha: 1) ?? .purple]
    var legalBGColor: [UIColor] = [UIColor.colorFromHex("2179FF", alpha: 1) ?? .blue, .red]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func moveToUpgradeVC() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.upgradeToProVC) as? UpgradeToProViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
        
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - SettingViewController: UITableViewDelegate, UITableViewDataSource

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else if section == 2 {
            return spreadLoveTitles.count
        } else if section == 3 {
            return legalTitles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UpgradeToPremiumImageCell", for: indexPath) as? UpgradeToPremiumImageCell {
                return cell
            }
        } else if indexPath.section == 2 || indexPath.section == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingOptionCell", for: indexPath) as? SettingOptionCell {
                if indexPath.section == 2 {
                    cell.optionLabel.text = spreadLoveTitles[indexPath.row]
                    cell.imageParentView.backgroundColor = spreadLoveBGColor[indexPath.row]
                    if indexPath.row == 0 {
                        cell.optionImageView.image = UIImage(named: spreadLoveIcons[0])

                    } else {
                        if #available(iOS 13.0, *) {
                            // Use SF Symbols for iOS 13 and later
                            cell.optionImageView.image = UIImage(systemName: spreadLoveIcons[indexPath.row])
                        } else {
                            // Use custom images for iOS 12 and earlier
                            cell.optionImageView.image = UIImage(named: spreadLoveIcons[indexPath.row])
                        }
                    }
                } else if indexPath.section == 3 {
                    cell.imageParentView.backgroundColor = legalBGColor[indexPath.row]
                    cell.optionLabel.text = legalTitles[indexPath.row]
                    if #available(iOS 13.0, *) {
                        // Use SF Symbols for iOS 13 and later
                        cell.optionImageView.image = UIImage(systemName: legalIcons[indexPath.row])
                    } else {
                        // Use custom images for iOS 12 and earlier
                        cell.optionImageView.image = UIImage(named: legalIcons[indexPath.row])
                    }
                }
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreAppCell", for: indexPath) as? MoreAppCell {
                cell.selectedAppLabel.text = "PDF App"
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            moveToUpgradeVC()
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                redirectToAppStore()
            } else if indexPath.row == 1 {
                shareURL(from: self, urlString: "")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }

        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = settingHeaders[section]
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0), // Adjust the constant for exact alignment
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
