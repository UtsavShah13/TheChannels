//
//  CategoryModel.swift
//  TheChannels
//
//  Created by Utsav Shah on 04/12/24.
//

import Foundation

struct CategoriesData : Codable {
    let categories : [Categories]?
    let chatimageen : String?
    let success : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case categories = "CATEGORIES"
        case chatimageen = "chatimageen"
        case success = "SUCCESS"
        case message = "MESSAGE"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        chatimageen = try values.decodeIfPresent(String.self, forKey: .chatimageen)
        success = try values.decodeIfPresent(String.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct Categories : Codable {
    let category_id : String?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case category_id = "category_id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
