//
//  ChannelDetailViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 05/12/24.
//

import UIKit
import SDWebImage

class ChannelDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIView!
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
        getChannelDetail(completion: { [self] in
            let imageSize: CGFloat = 45
            let overlapOffset: CGFloat = -10
            var previousImageView: UIImageView?

            // A container view for all images
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.addSubview(containerView)
            
            // Center the container view within profileImageView
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
            ])
            
            if let images = channelFollowresImage {
                for (index, imageName) in images.enumerated() {
                    let imageUrl = URL(string: imageName)
                    let imageView = UIImageView() // Create an instance of UIImageView
                    imageView.sd_setImage(with: imageUrl)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageView.layer.borderColor = UIColor.white.cgColor
                    imageView.layer.borderWidth = 2
                    imageView.layer.cornerRadius = imageSize / 2
                    imageView.layer.zPosition = CGFloat(images.count - index) // First image on top
                    
                    containerView.addSubview(imageView)
                    
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalToConstant: imageSize),
                        imageView.heightAnchor.constraint(equalToConstant: imageSize),
                        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                    ])
                    
                    if let previous = previousImageView {
                        // Position the current image relative to the previous image
                        NSLayoutConstraint.activate([
                            imageView.leadingAnchor.constraint(equalTo: previous.trailingAnchor, constant: overlapOffset)
                        ])
                    } else {
                        // Position the first image
                        NSLayoutConstraint.activate([
                            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
                        ])
                    }
                    
                    // If it's the last image, add the three dots overlay
                    if index == images.count - 1 {
                        let dotsLabel = UILabel()
                        dotsLabel.translatesAutoresizingMaskIntoConstraints = false
                        dotsLabel.text = "●●●"
                        dotsLabel.textAlignment = .center
                        dotsLabel.textColor = UIColor.white.withAlphaComponent(0.7) // Opacity
                        dotsLabel.font = UIFont.systemFont(ofSize: 6)
                        
                        let overlay = UIView()
                        overlay.translatesAutoresizingMaskIntoConstraints = false
                        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.6) // Adjust alpha for transparency
                        overlay.layer.cornerRadius = imageSize / 2
                        overlay.isUserInteractionEnabled = false // Ensure it doesn't block touch events
                        
                        imageView.addSubview(overlay)
                        imageView.addSubview(dotsLabel)
                        
                        NSLayoutConstraint.activate([
                            overlay.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                            overlay.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                            overlay.topAnchor.constraint(equalTo: imageView.topAnchor),
                            overlay.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                            
                            dotsLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                            dotsLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
                        ])
                    }
                    
                    previousImageView = imageView
                }
                
                // Adjust container view's width based on total images
                let totalWidth = imageSize + CGFloat(images.count - 1) * (imageSize + overlapOffset)
                NSLayoutConstraint.activate([
                    containerView.widthAnchor.constraint(equalToConstant: totalWidth),
                    containerView.heightAnchor.constraint(equalToConstant: imageSize)
                ])
            }
        })

        fillData()
        setupUI()
    }
    
    func setupUI() {
        reportChannelButton.layer.cornerRadius = 8
        addChannelButton.layer.cornerRadius = 8
        detailView.layer.cornerRadius = 8
        shareView.layer.cornerRadius = 8
        forwardView.layer.cornerRadius = 8
        followView.layer.cornerRadius = 8
        groupActionView.layer.cornerRadius = 8
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
    }
    
    func moveToAddChannel() {
        let storyBoard = UIStoryboard(name: StoryBoard.main, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Controller.addChannelVC) as? AddChannelViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func shareLink(_ urlString: String, from viewController: UIViewController) {
        guard let url = URL(string: urlString) else {
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
        reportChannelApi()
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
