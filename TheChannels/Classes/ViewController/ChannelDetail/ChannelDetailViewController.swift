//
//  ChannelDetailViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 05/12/24.
//

import UIKit
import SDWebImage

class ChannelDetailViewController: UIViewController {
    
    @IBOutlet weak var groupActionView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var forwardView: UIView!
    @IBOutlet weak var followView: UIView!
    @IBOutlet weak var reportChannelButton: UIButton!
    @IBOutlet weak var addChannelButton: UIButton!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var channelImageView: UIImageView!
    
    var channel: Channel?
    var channelFollowresImage: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getChannelDetail()
        fillData()
        setupUI()
    }
    
    func setupUI() {
    
        reportChannelButton.layer.cornerRadius = 8
        addChannelButton.layer.cornerRadius = 8
        
        addShadow(view: detailView)
        addShadow(view: shareView)
        addShadow(view: forwardView)
        addShadow(view: followView)
        addShadow(view: groupActionView)

    }
    
    func fillData() {
        detailLabel.text = channel?.description
        nameLabel.text = channel?.title
        followerLabel.text = "\(channel?.subscribersf ?? "0")"
        channelImageView.layer.cornerRadius = channelImageView.frame.height / 2
        let imageUrl = URL(string: channel?.pic_thumb ?? "")
        channelImageView.sd_setImage(with: imageUrl)
    }
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor // Shadow color
        view.layer.shadowOpacity = 0.3                // Shadow transparency (0 to 1)
        view.layer.shadowOffset = CGSize(width: 1, height: 1) // Shadow offset
        view.layer.shadowRadius = 2
        view.layer.cornerRadius = 8
    }
    
    func moveToAddChannel() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.addChannelVC) as? AddChannelViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func shareLink(_ urlString: String, from viewController: UIViewController) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Items to share
        let items: [Any] = [url]
        
        // Initialize UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                
        // Present the activity view controller
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
//    MARK: - Button Action
    @IBAction func reportGroupAction(_ sender: UIButton) {
        
    }
    @IBAction func exitGroupAction(_ sender: UIButton) {
        exitChannelApi()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        shareLink(channel?.join_link ?? "", from: self)
    }
    
    @IBAction func forwardAction(_ sender: UIButton) {
        forwardChannelApi()
    }
    
    
    @IBAction func followAction(_ sender: UIButton) {
        followChannelApi()
    }
    @IBAction func addChannelAction(_ sender: UIButton) {
        moveToAddChannel()
    }
    
    @IBAction func reportAction(_ sender: UIButton) {
        reportChannelApi()
    }
}
