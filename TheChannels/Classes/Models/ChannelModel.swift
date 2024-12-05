//
//  ChannelModel.swift
//  TheChannels
//
//  Created by Utsav Shah on 04/12/24.
//

import Foundation

struct ChannelData : Codable {
    let channels : [Channel]?
    let success : String?
    let message : String?
    let isSearchPaid : String?
    let rFORR : String?

    enum CodingKeys: String, CodingKey {

        case channels = "CHANNELS"
        case success = "SUCCESS"
        case message = "MESSAGE"
        case isSearchPaid = "IS_SEARCH_PAID"
        case rFORR = "RFORR"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(String.self, forKey: .success)
        isSearchPaid = try values.decodeIfPresent(String.self, forKey: .isSearchPaid)
        rFORR = try values.decodeIfPresent(String.self, forKey: .rFORR)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        channels = try values.decodeIfPresent([Channel].self, forKey: .channels)
    }

}

struct Channel : Codable {
    let channel_id : String?
    let title : String?
    let pic : String?
    let is_promoted : String?
    let pic_thumb : String?
    let is_verified : String?
    let join_link : String?
    let description : String?
    let subscribersf: String?

    enum CodingKeys: String, CodingKey {

        case channel_id = "channel_id"
        case title = "title"
        case pic = "pic"
        case is_promoted = "is_promoted"
        case pic_thumb = "pic_thumb"
        case is_verified = "is_verified"
        case join_link = "join_link"
        case description = "description"
        case subscribersf = "subscribersf"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel_id = try values.decodeIfPresent(String.self, forKey: .channel_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        pic = try values.decodeIfPresent(String.self, forKey: .pic)
        is_promoted = try values.decodeIfPresent(String.self, forKey: .is_promoted)
        pic_thumb = try values.decodeIfPresent(String.self, forKey: .pic_thumb)
        is_verified = try values.decodeIfPresent(String.self, forKey: .is_verified)
        join_link = try values.decodeIfPresent(String.self, forKey: .join_link)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        subscribersf = try values.decodeIfPresent(String.self, forKey: .subscribersf)
    }

}
