//
//  IssueResponse.swift
//  GHKanban
//
//  Created by Diego on 31/10/21.
//

import Foundation

/// Model for the Issue from the API call, which later will be converted to the Core Data model
struct IssueResponse: Decodable, Hashable {
    let title: String
    let body: String
    let idNum: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
        idNum = try values.decode(Int.self, forKey: .id)
    }
}
