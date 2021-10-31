//
//  Repository.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import Foundation

struct Repository: Identifiable, Equatable {
    
    let id = UUID()
    let repoName: String
    let repoAuthor: String
    var repoIssues: [Issue]
    
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.id == rhs.id
    }
}
