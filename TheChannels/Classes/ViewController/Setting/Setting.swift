//
//  SettingViewController.swift
//  TheChannels
//
//  Created by Utsav Shah on 29/11/24.
//

import UIKit
import SDWebImage

class UpgradeToPremiumImageCell: UITableViewCell {


    @IBOutlet weak var premiumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        premiumImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

class SettingOptionCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        addShadow(view: mainView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor // Shadow color
        view.layer.shadowOpacity = 0.3                // Shadow transparency (0 to 1)
        view.layer.shadowOffset = CGSize(width: 1, height: 1) // Shadow offset
        view.layer.shadowRadius = 2
        view.layer.cornerRadius = 8
    }
}
//
//
//class SettingViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    func setupUI() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    @IBAction func backAction(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
//            return 3
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "UpgradeToPremiumImageCell", for: indexPath) as? UpgradeToPremiumImageCell
//            {
//                return cell
//            }
//
//        } else if indexPath.section == 1 {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingOptionCell", for: indexPath) as? SettingOptionCell
//            {
//                return cell
//            }
//        }
//        return UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return ""
//        } else {
//            return "Settings"
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0
//        } else {
//            return 40
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//}


import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

//        tableView.register(UINib(nibName: "BannerCell", bundle: nil), forCellReuseIdentifier: "BannerCell")
//        tableView.register(UINib(nibName: "HorizontalAppsCell", bundle: nil), forCellReuseIdentifier: "HorizontalAppsCell")
//        tableView.register(UINib(nibName: "OptionCell", bundle: nil), forCellReuseIdentifier: "OptionCell")
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else if section == 2 {
            return 3 // Spread Love options
        } else {
            return 2 // Legal options
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpgradeToPremiumImageCell", for: indexPath) as! UpgradeToPremiumImageCell
//            cell.bannerImageView.image = UIImage(named: "premium_banner")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingOptionCell", for: indexPath) as! SettingOptionCell
            return cell
        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
//            let titles = ["Rate Us", "Share App", "Help"]
//            let icons = [UIImage(named: "rate_us"), UIImage(named: "share"), UIImage(named: "help")]
//            cell.configure(title: titles[indexPath.row], icon: icons[indexPath.row])
//            return cell
            break
        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
//            let titles = ["Privacy Policy", "Terms of Use"]
//            let icons = [UIImage(named: "privacy"), UIImage(named: "terms")]
//            cell.configure(title: titles[indexPath.row], icon: icons[indexPath.row])
//            return cell
            break
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200 // Banner height
        } else if indexPath.section == 1 {
            return 140 // Horizontal apps
        } else {
            return 50 // Default cell height
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}
