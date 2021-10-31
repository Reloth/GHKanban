//
//  KanbanView.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import SwiftUI

/// This is the board view, where all Issues from a single Repository are shown,  you can move them to a different column in the same board.
struct KanbanView: View {

    
    @StateObject var kanbanViewModel: KanbanViewModel
    
    init(repository: Repository) {
        self._kanbanViewModel = StateObject(wrappedValue: KanbanViewModel(repository: repository))
    }
    
    var body: some View {
        TabView {
            backlogView
            nextView
            doingView
            doneView
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

fileprivate extension KanbanView {
    
    var backlogView: some View {
        List {
            ForEach(kanbanViewModel.issues.filter{ $0.issuePosition == .backlog}) { issue in
                issueCell(issue: issue)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .listStyle(.plain)
    }
    
    var nextView: some View {
        List {
            ForEach(kanbanViewModel.issues.filter{ $0.issuePosition == .next}) { issue in
                issueCell(issue: issue)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .listStyle(.plain)
    }
    
    var doingView: some View {
        List {
            ForEach(kanbanViewModel.issues.filter{ $0.issuePosition == .doing}) { issue in
                issueCell(issue: issue)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .listStyle(.plain)
    }
    
    var doneView: some View {
        List {
            ForEach(kanbanViewModel.issues.filter{ $0.issuePosition == .done}) { issue in
                issueCell(issue: issue)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .listStyle(.plain)
    }
    
    func issueCell(issue: Issue) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text("**\(issue.issueTitle)**")
                Text("*\(issue.issueInformation)*")
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 30) {
                if issue.issuePosition != .done {
                    Button {
                        kanbanViewModel.increaseIssuePosition(issue: issue)
                    } label: {
                        Image(systemName: "arrow.right.square.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                }
                if issue.issuePosition != .backlog {
                    Button {
                        kanbanViewModel.decreaseIssuePosition(issue: issue)
                    } label: {
                        Image(systemName: "arrow.left.square.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
                }

            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding()
    }
}

struct KanbanView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanView(repository: mockRepos.first!)
    }
}
