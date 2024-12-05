//
//  ChannelDetailViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 05/12/24.
//

import UIKit

class ChannelDetailViewController: UIViewController {
    
    var channel: Channel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
