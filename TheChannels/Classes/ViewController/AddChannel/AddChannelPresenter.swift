//
//  AddChannelPresenter.swift
//  TheChannels
//
//  Created by Utsav on 10/12/24.
//

import Foundation

extension AddChannelViewController {
    
    func addChannel() {
        Utils.showSpinner()
        var param: [String: Any] = ["title": titleTextField.text as Any, "channel_link": linkTextField.text as Any, "category_id": selectedCategory?.category_id ?? 0, "datetime": dateTextField.text as Any, "country_code": countryCodeiOSDropDown.text ?? "", "phone_number": phoneNumberTextField.text ?? "", "description": descriptionTextView.text ?? ""]
        
        if imageData?.isEmpty ?? false {
            param["prole_pic"] = imageData
        }
        
        if coverImageData?.isEmpty ?? false {
            param["cover_pic"] = coverImageData
        }
        
        NetworkManager.shared.postAddChannelsApi(param: param) { result in
            Utils.hideSpinner()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getCategories() {
        Utils.showSpinner()
        NetworkManager.shared.getCategoriesDataAPI(completion: { data in
            Utils.hideSpinner()
            self.categories = data ?? []
        })
    }
}
