//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cell nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func register(view nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func updateTable() {
        // Disable animations
        UIView.setAnimationsEnabled(false)
        beginUpdates()
        endUpdates()
        // Enable animations
        UIView.setAnimationsEnabled(true)
    }
    
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
    func updateFooterViewHeight() {

        if let footer = self.tableFooterView {
            let newSize = footer.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            footer.frame.size.height = newSize.height
        }
    }
}

extension UICollectionView {
    func register(cell nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func register(view nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
