//
//  SettingViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 29/11/24.
//

import UIKit
import SDWebImage

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

class MoreAppCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appImageView.layer.cornerRadius = 12
    }

}

class MoreAppCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var appCollectionView: UICollectionView!
    @IBOutlet weak var selectedAppLabel: UILabel!
    @IBOutlet weak var installButton: UIButton!
    var getMoreApps: [[String : String]] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        getMoreApps = MoreApps.getMoreApps()
        appCollectionView.reloadData()
        print(getMoreApps.count)
    }
    
    func setup() {
        installButton.layer.cornerRadius = 8
        appCollectionView.delegate = self
        appCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 120, height: 120)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        appCollectionView.showsHorizontalScrollIndicator = false
        appCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func installButtonAction(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMoreApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreAppCollectionCell", for: indexPath) as? MoreAppCollectionCell {
            let imageUrl = URL(string: getMoreApps[indexPath.row]["appimage"] ?? "")
            cell.appImageView.sd_setImage(with: imageUrl)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
}

class SettingOptionCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var settingHeaders = ["", "More APPS", "SPREAD LOVE", "LEGAL"]
    var spreadLoveTitles = ["Rate Us", "Share App", "Help"]
    var legalTitles = ["Privacy Policy", "Terms of use"]
    var spreadLoveIcons = ["rate", "share", "help"]
    var legalIcons = ["privacy", "terms"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

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
                } else if indexPath.section == 3 {
                    cell.optionLabel.text = legalTitles[indexPath.row]
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
