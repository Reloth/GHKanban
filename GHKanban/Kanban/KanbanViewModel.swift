//
//  KanbanViewModel.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import Foundation
import Combine

/// This ViewModel is used to manage all necessary variables and functions for a KanbanView to operate (and later will be used to store locally the last state of the Kanban).
class KanbanViewModel: ObservableObject {
    
    @Published var repository: Repository
    @Published var issues: [Issue]
    var cancellables = [AnyCancellable]()
    
    init(repository: Repository) {
        self.repository = repository
        self.issues = repository.repoIssues
        
        /// Need to subscribe the individual Issue objectWillChange for the Issues array to trigger a change when the Issue position has changed
        self.issues.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })
            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
    }
    
    func increaseIssuePosition(issue: Issue) {
        debugPrint("increaseIssuePosition")
        guard let issueToChange = issues.first(where: { issueToFind in
            issueToFind.id == issue.id
        }) else { return }
        
        
        if let newPosition = IssuePosition(rawValue: issue.issuePosition.rawValue + 1) {
            issueToChange.issuePosition = newPosition
        }
        
    }
    
    func decreaseIssuePosition(issue: Issue) {
        debugPrint("decreaseIssuePosition")
        guard let issueToChange = issues.first(where: { issueToFind in
            issueToFind.id == issue.id
        }) else { return }
        
        
        if let newPosition = IssuePosition(rawValue: issue.issuePosition.rawValue - 1) {
            issueToChange.issuePosition = newPosition
        }
    }
    
    func getTitleForSelectedTab(position: IssuePosition) -> String {
        switch position {
            case .backlog:
                return "Backlog"
            case .next:
                return "Next"
            case .doing:
                return "Doing"
            case .done:
                return "Done"
        }
    }
}
