//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//
import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var channels: [Channel] = []
    var categories: [Categories] = []
    var selectedCategory: Int? = 0
    var currentPage: Int = 0
    var isContainMoreData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCategories()
    }

    func setupUI() {
        searchView.layer.cornerRadius = 12
        searchView.backgroundColor = UIColor.colorFromHex("E4E4E6", alpha: 1)
        setupTableView()
        setupCollectionView()
        
        searchTextField.delegate = self
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
    
    func moveToAddChannel() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.addChannelVC) as? AddChannelViewController {
            vc.categories = categories
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveToSetting() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.settingVC) as? SettingViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveToChannelDetail(channel: Channel) {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.channelDetailsVC) as? ChannelDetailViewController {
            vc.channel = channel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    MARK: Button Action
    
    @IBAction func settingAction(_ sender: UIButton) {
        moveToSetting()
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        moveToAddChannel()
    }
    
}

//MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the new text
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Call your search API with updatedText
        performSearch(with: updatedText)

        return true
    }
    
    func performSearch(with query: String) {
        // Ensure query is not empty to prevent unnecessary API calls
        guard !query.isEmpty else { return }
                
        getSearchChannels(searchText: query, page: 1)
    }
}

//    MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.channelsCell, for: indexPath) as? ChannelsTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = channels[indexPath.row].title
        cell.followersLabel.text = channels[indexPath.row].title
        if channels[indexPath.row].is_verified == "0" {
            cell.varifiedImageView.isHidden = true
        } else {
            cell.varifiedImageView.isHidden = false
        }
        cell.followersLabel.text = channels[indexPath.row].subscribersf
        cell.followButton.tintColor = UIColor.colorFromHex("DFFCD6", alpha: 1)
        cell.followButton.titleLabel?.textColor = UIColor.colorFromHex("3E6F56", alpha: 1)
        cell.followButton.backgroundColor = UIColor.colorFromHex("DFFCD6", alpha: 1)
        let imageUrl = URL(string: channels[indexPath.row].pic_thumb ?? "")
        if imageUrl != nil {
            cell.categoryImageView?.sd_setImage(with: imageUrl)
        }
        cell.handleFollowButton = { [self] in
            followChannel(channelId: channels[indexPath.row].channel_id ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToChannelDetail(channel: channels[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if channels.count == indexPath.row + 2 && isContainMoreData {
            currentPage += 1
            getChannels(categoryId:  categories[selectedCategory ?? 0].category_id ?? "", page: currentPage)
        }
    }

}

//    MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.categoriesCell, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.categoryLabel.text = categories[indexPath.item].title
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
        getChannels(categoryId: categories[selectedCategory ?? 0].category_id ?? "", page: 0)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item].title
        
        // Calculate the text width
        let textWidth = text?.size(withAttributes: [.font: UIFont.boldSystemFont(ofSize: 17)]).width
        
        // Add padding
        return CGSize(width: (textWidth ?? 0) + 32, height: 45)
    }

}
