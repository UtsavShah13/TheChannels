//
//  CategoriesCollectionViewCell.swift
//  TheChannels
//
//  Created by Utsav Shah on 01/12/24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = mainView.frame.height / 2.5
    }

}
