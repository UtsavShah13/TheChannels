//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var channels = ["AajTak","Sun News","RJ Kajal","Zee News","Times Now","The Wire"]
    var categories = ["General","Sports","Entertainment","Technology","Business","Health", "Lifestyle", "Travel", "Food", "Auto", "Gaming", "Science", "Fashion", "Music", "Politics", "Religion", "Sports", "Entertainment", "Technology", "Business", "Health", "Lifestyle", "Travel", "Food", "Auto", "Gaming", "Science", "Fashion", "Music", "Politics", "Religion"]
    var selectedCategory: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        searchView.layer.cornerRadius = 12
        searchView.backgroundColor = UIColor.colorFromHex("E4E4E6", alpha: 1)
        setupTableView()
        setupCollectionView()
    }
    
    
    func setupTableView() {
        tableView.register(cell: Cell.channelsCell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func setupCollectionView() {
        collectionView.register(cell: Cell.categoriesCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 0
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = flowLayout
    }
    
    func moveToSetting() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.settingVC) as? SettingViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveToChannelDetail() {
        
    }
    
//    MARK: Button Action
    
    @IBAction func settingAction(_ sender: UIButton) {
        moveToSetting()
    }
}

//    MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.channelsCell, for: indexPath) as? ChannelsTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = channels[indexPath.row]
        cell.followButton.tintColor = UIColor.colorFromHex("DFFCD6", alpha: 1)
        cell.followButton.titleLabel?.textColor = UIColor.colorFromHex("3E6F56", alpha: 1)
        cell.followButton.backgroundColor = UIColor.colorFromHex("DFFCD6", alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToChannelDetail()
    }

}

//    MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.categoriesCell, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.categoryLabel.text = categories[indexPath.item]
        if indexPath.item == selectedCategory {
            cell.categoryLabel.textColor = UIColor.colorFromHex("3E6F56", alpha: 1)
            cell.mainView.backgroundColor = UIColor.colorFromHex("DFFCD6", alpha: 1)
        } else {
            cell.categoryLabel.textColor = UIColor.colorFromHex("797B7C", alpha: 1)
            cell.mainView.backgroundColor = UIColor.colorFromHex("E4E4E6", alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = indexPath.item
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item]
        
        // Calculate the text width
        let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width
        
        // Add padding
        return CGSize(width: textWidth + 32, height: 45)
    }

}
