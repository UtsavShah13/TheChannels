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
        var param: [String: Any] = ["title":titleTextField.text, "channel_link":linkTextField.text, "category_id":"12", "datetime":Date(), "country_code":"+91", "phone_number":"9662612345", "description":"descriptionTextView.text"]
//        param[""] =
//        param[""] =
//        param[""] = "12"// selectedCategory?.category_id
//        param[""] = Date()
//        param[""] = "+91"
//        param[""] = "9662612345"
//        param["description"] =
//        param["prole_pic"] = ""
//        param["cover_pic"] =
        
        NetworkManager.shared.postAddChannelsApi(param: param) { result in
            print(result)
        }
    }
}
