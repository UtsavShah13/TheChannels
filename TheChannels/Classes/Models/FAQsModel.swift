//
//  FAQsModel.swift
//  TheChannels
//
//  Created by Utsav Shah on 21/12/24.
//

import Foundation


struct FAQsModel: Decodable {
    let question : String?
    let answer : String?
    var isOpen : Bool = false

//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        question = try values.decodeIfPresent(String.self, forKey: .question)
//        answer = try values.decodeIfPresent(String.self, forKey: .answer)
//        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen) ?? false
//    }

}
