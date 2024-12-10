//
//  AddChannelPresenter.swift
//  TheChannels
//
//  Created by ideveloper9 on 10/12/24.
//

import Foundation

extension AddChannelViewController {
//    https://appcodism.com/davidapps/thechannels/index.php?
//    function=addchannel&title=hello&channel_link=hello.com&category_id=12&d
//    atetime=031220240430PM&country_code=+91&phone_number=9898989898
//    &description=hellodescription
    
    func addChannel() {
        Utils.showSpinner()
        var param: [String: Any] = [:]
        param["title"] = titleTextField.text
        param["channel_link"] = linkTextField.text
//        param["category_id"] = categoryId
//        param["datetime"] = dateTime
//        param["country_code"] = countryCode
//        param["phone_number"] = phoneNumber
        param["description"] = descriptionTextView.text
        NetworkManager.shared.postAddChannelsApi(param: [:]) { result in
            print(result)
        }
    }
}
