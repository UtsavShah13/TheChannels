//
//  ChannelDetailModel.swift
//  TheChannels
//
//  Created by Utsav Shah on 12/12/24.
//

import Foundation

struct ChannelDetailModel : Codable {
    let sUCCESS : String?
    let mESSAGE : String?
    let sUBSCRIBERS : [String]?

    enum CodingKeys: String, CodingKey {

        case sUCCESS = "SUCCESS"
        case mESSAGE = "MESSAGE"
        case sUBSCRIBERS = "SUBSCRIBERS"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sUCCESS = try values.decodeIfPresent(String.self, forKey: .sUCCESS)
        mESSAGE = try values.decodeIfPresent(String.self, forKey: .mESSAGE)
        sUBSCRIBERS = try values.decodeIfPresent([String].self, forKey: .sUBSCRIBERS)
    }

}
