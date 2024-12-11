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
    
    func getChannelDetailAPI(param: [String: Any], completion: @escaping ((_ result: [String]?) -> Void)) {
        let apiURL = API.channelDetails.rawValue
        NetworkManager.shared.requestGet(path: apiURL, params: param) { (result, error, statusCode) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }

            if let response: ChannelDetailModel = self.decodeObject(fromData: data), response.sUCCESS == "1" {
                completion(response.sUBSCRIBERS)
            } else {
                Utils.alert(message: "Invalid response")
                Utils.hideSpinner()
                completion(nil)
            }
        }
    }
    
    func getChannelsApi(param: [String: Any], completion: @escaping((_ result: ChannelData?) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.getChannelList.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response)
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func getReportChannelApi(param: [String: Any], completion: @escaping((String) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.reportChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion("")
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.message ?? "")
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }
    
//    func getFollowChannelApi(param: [String: Any], completion: @escaping((String) -> Void)) {
//        
//        NetworkManager.shared.requestPost(path: API.followChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
//            guard error == nil, let data = result else {
//                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
//                Utils.hideSpinner()
//                completion("")
//                return
//            }
//            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
//                completion(response.message ?? "")
//            } else {
//                Utils.hideSpinner()
//                Utils.alert(message: error?.localizedDescription ?? "")
//            }
//        }
//    }
    
    func getExitChannelApi(param: [String: Any], completion: @escaping((String) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.exitChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion("")
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.message ?? "")
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }

    func getForwardChannelApi(param: [String: Any], completion: @escaping((String) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.forwardChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion("")
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response.message ?? "")
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func getViewedChannelApi(param: [String: Any], completion: @escaping(() -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.viewChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion()
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion()
            } else {
                Utils.hideSpinner()
                Utils.alert(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func getSearchedChannelsApi(param: [String: Any], completion: @escaping((_ result: ChannelData?) -> Void)) {
        
        NetworkManager.shared.requestPost(path: API.searchChannel.rawValue, params: param, contentType: .formUrlencoded) { (result, error, _) in
            guard error == nil, let data = result else {
                Utils.alert(message: error?.localizedDescription ?? "Failed to fetch data")
                Utils.hideSpinner()
                completion(nil)
                return
            }
            if let response: ChannelData = self.decodeObject(fromData: data), response.success == "1" {
                completion(response)
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
    
    func postAddChannelsApi(param: [String: Any], completion: @escaping((_ result: String?) -> Void)) {
        
        NetworkManager.shared.requestUploadImage(path: API.addChannel.rawValue, params: param, contentType: .formData, resultHandler: {(result, error, _)in
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
        })
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
