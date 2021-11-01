//
//  RepositoriesResponse.swift
//  GHKanban
//
//  Created by Diego on 31/10/21.
//

import Foundation

/// Model for the Repository from the API call, which later will be converted to the Core Data model
struct RepositoryResponse: Decodable, Hashable {
    let name: String
    let author: String
    let idNum: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        idNum = try values.decode(Int.self, forKey: .id)
        
        let owner = try values.decode(Owner.self, forKey: .owner)
        author = owner.login
    }
}

/// Needed an Owner model to retrieve the author name
struct Owner: Decodable {
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case login
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decode(String.self, forKey: .login)
    }
    
}
