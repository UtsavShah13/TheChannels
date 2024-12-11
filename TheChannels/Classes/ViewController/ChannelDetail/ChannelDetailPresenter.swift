//
//  ChannelDetailPresenter.swift
//  TheChannels
//
//  Created by Utsav Shah on 12/12/24.
//

import Foundation

extension ChannelDetailViewController {
    
    func getChannelDetail() {
        Utils.showSpinner()
        let param = ["channel_id": channel?.channel_id ?? ""]
        NetworkManager.shared.getChannelDetailAPI(param: param, completion: { [self] result in
            print(result as Any)
            channelFollowresImage = result 
            Utils.hideSpinner()
        })
    }
    
    func postViewDetail() {
        Utils.showSpinner()
        let param = ["channel_id": channel?.channel_id ?? ""]
        NetworkManager.shared.getViewedChannelApi(param: param, completion: {
            Utils.hideSpinner()
        })
    }
    
    func followChannelApi() {
        Utils.showSpinner()
        let param = ["channel_id": channel?.channel_id ?? ""]
        NetworkManager.shared.postFollowChannelsApi(param: param, completion: { result in
            print(result as Any)
            Utils.alert(message: result ?? "")
            Utils.hideSpinner()
        })
    }

    func exitChannelApi() {
        Utils.showSpinner()
        let param = ["channel_id": channel?.channel_id ?? ""]
        NetworkManager.shared.getExitChannelApi(param: param, completion: { result in
            print(result as Any)
            Utils.alert(message: result)
            self.navigationController?.popToRootViewController(animated: true)
            Utils.hideSpinner()
        })
    }
    
    func forwardChannelApi() {
        Utils.showSpinner()
        let param = ["channel_id": channel?.channel_id ?? ""]
        NetworkManager.shared.getForwardChannelApi(param: param, completion: { result in
            print(result as Any)
            Utils.alert(message: result)
            Utils.hideSpinner()
        })
    }
    
    func reportChannelApi() {
        Utils.showSpinner()
        let param = ["channel_id": channel?.channel_id ?? ""]
        NetworkManager.shared.getReportChannelApi(param: param, completion: { result in
            print(result as Any)
            Utils.alert(message: result)
            Utils.hideSpinner()
        })
    }
}
