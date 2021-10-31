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
        self.issues = repository.issues
        
        /// Need to subscribe the individual Issue objectWillChange for the Issues array to trigger a change when the Issue position has changed
        self.issues.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { self.objectWillChange.send() })
            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
    }
    
    func increaseIssuePosition(issue: Issue) {
        if let newPosition = IssuePosition(rawValue: issue.wrappedPosition.rawValue + 1) {
            issue.wrappedPosition = newPosition
            PersistenceController.shared.save()
        }
        
    }
    
    func decreaseIssuePosition(issue: Issue) {
        if let newPosition = IssuePosition(rawValue: issue.wrappedPosition.rawValue - 1) {
            issue.wrappedPosition = newPosition
            PersistenceController.shared.save()
        }
    }
    
}
