//
//  Issue.swift
//  GHKanban
//
//  Created by Diego on 31/10/21.
//

import Foundation

public enum IssuePosition: Int, Equatable {
    case backlog = 0
    case next = 1
    case doing = 2
    case done = 3
}
