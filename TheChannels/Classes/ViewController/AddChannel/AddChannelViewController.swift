//
//  AddChannelViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 06/12/24.
//

import UIKit

class AddChannelViewController: UIViewController {

    @IBOutlet weak var addChannelBtn: UIButton!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var chooseCoverImageView: UILabel!
    @IBOutlet weak var uploadCoverImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        addChannelBtn.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            descriptionTextView.borderColor = .systemGray5
        } else {
            descriptionTextView.borderColor = .systemGray
        }
        descriptionTextView.borderWidth = 1
    }
    
//    MARK: - Button Action
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func appPictureAction(_ sender: UIButton) {
        
    }
    
    @IBAction func addChannelAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadCoverImageViewAction(_ sender: UIButton) {
        
    }
}
