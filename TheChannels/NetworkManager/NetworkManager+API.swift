//
//  NetworkManager+API.swift
//  TheChannels
//
//  Created by Utsav Shah on 04/12/24.
//

import Foundation
import UIKit

extension NetworkManager {
    
    func getCategoriesDataAPI(completion: @escaping ((_ result: [Categories]?) -> Void)) {
        let apiURL = API.channelCategory.rawValue
        NetworkManager.shared.requestGet(path: apiURL, params: [:]) { (result, error, statusCode) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }

            if let response: CategoriesData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.categories)
            } else {
                Utils.alert(message: "Invalid response")
                Utils.hideSpinner()
                completion(nil)
            }
        }
    }
    
    func getChannelsApi(param: [String: Any], completion: @escaping((_ result: [Channel]?) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.getChannelList.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.channels)
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func getSearchedChannelsApi(param: [String: Any], completion: @escaping((_ result: [Channel]?) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.searchChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.channels)
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func postFollowChannelsApi(param: [String: Any], completion: @escaping((_ result: String?) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.followChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.message)
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }

func handleError(_ message: String) {
    Utils.hideSpinner()
    if !message.isEmpty {
        Utils.alert(message: message)
    }
}

func decodeObject<T: Decodable>(fromData data: Any?) -> T? {
    if let data = data {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
                    
        return try? jsonDecoder.decode(
            T.self, from: JSONSerialization.data(withJSONObject: data, options: [])
        ) as T?
    } else {
        return nil
    }
}
}
