//
//  AddChannelPresenter.swift
//  TheChannels
//
//  Created by ideveloper9 on 10/12/24.
//

import Foundation

extension AddChannelViewController {
    
    func addChannel() {
        Utils.showSpinner()
        let param: [String: Any] = ["title": titleTextField.text as Any, "channel_link": linkTextField.text as Any, "category_id": selectedCategory?.category_id ?? 0, "datetime": dateTextField.text as Any, "country_code": countryCodeiOSDropDown.text ?? "", "phone_number": phoneNumberTextField.text ?? "", "description": descriptionTextView.text ?? "", "cover_pic": coverImageData ?? Data(), "prole_pic": imageData ?? Data() ]
        
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
