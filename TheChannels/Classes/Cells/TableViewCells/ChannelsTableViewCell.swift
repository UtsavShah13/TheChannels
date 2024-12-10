//
//  ChannelsTableViewCell.swift
//  TheChannels
//
//  Created by Utsav Shah on 01/12/24.
//

import UIKit

class ChannelsTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var varifiedImageView: UIImageView!
    
    var handleFollowButton: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        followButton.layer.cornerRadius = 10
        categoryImageView.layer.cornerRadius = categoryImageView.frame.height / 2
    }
    
    @IBAction func folloAction(_ sender: UIButton) {
        self.handleFollowButton?()
    }
}
