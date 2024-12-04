//
//  HomeVCPresenter.swift
//  TheChannels
//
//  Created by Utsav Shah on 04/12/24.
//

import Foundation

extension HomeViewController {
    
    func getCategories() {
        Utils.showSpinner()
        NetworkManager.shared.getCategoriesDataAPI(completion: { data in
            Utils.hideSpinner()
            self.categories = data ?? []
            self.getChannels(categoryId: self.categories.first?.category_id ?? "")
            self.collectionView.reloadData()
        })
    }
    
    func getChannels(categoryId: String) {
        Utils.showSpinner()
        let param: [String: Any] = ["category_id": 3, "from": 0]
        NetworkManager.shared.getChannelsApi(param: param, completion: { data in
            Utils.hideSpinner()
            self.channels = data ?? []
            self.tableView.reloadData()
            print(data as Any)
        })
    }
}
