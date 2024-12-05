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
            self.getChannels(categoryId: self.categories.first?.category_id ?? "", page: 0)
            self.collectionView.reloadData()
        })
    }
    
    func getChannels(categoryId: String, page: Int) {
        Utils.showSpinner()
        if page == 0 {
            channels = []
        }
        let param: [String: Any] = ["category_id": categoryId, "from": page]
        NetworkManager.shared.getChannelsApi(param: param, completion: { data in
            Utils.hideSpinner()
            self.channels = data ?? []
            self.tableView.reloadData()
            self.collectionView.reloadData()
            print(data as Any)
        })
    }
    
    func getSearchChannels(searchText: String, page: Int) {
        Utils.showSpinner()
        let param: [String: Any] = ["search_text": searchText, "from": page]
        NetworkManager.shared.getSearchedChannelsApi(param: param, completion: { data in
            Utils.hideSpinner()
            self.channels = data ?? []
            self.tableView.reloadData()
            print(data as Any)
        })
    }
    
    func followChannel(channelId: String) {
        Utils.showSpinner()
        let param: [String: Any] = ["channel_id": channelId]
        NetworkManager.shared.postFollowChannelsApi(param: param, completion: { data in
            Utils.hideSpinner()
        })
    }

    
}
