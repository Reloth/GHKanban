//
//  Issue.swift
//  GHKanban
//
//  Created by Diego on 31/10/21.
//

import Foundation

//class Issue: Identifiable, ObservableObject {
//    let id = UUID()
//    let issueTitle: String
//    let issueInformation: String
//    @Published var issuePosition: IssuePosition
//    
//    init(issueTitle: String, issueInformation: String, issuePosition: IssuePosition) {
//        self.issueTitle = issueTitle
//        self.issueInformation = issueInformation
//        self.issuePosition = issuePosition
//    }
//}

public enum IssuePosition: Int, Equatable {
    case backlog = 0
    case next = 1
    case doing = 2
    case done = 3
}
