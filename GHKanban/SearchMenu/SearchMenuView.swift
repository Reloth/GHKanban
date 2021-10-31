//
//  SearchMenuView.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import SwiftUI

/// This is the main View of the app, where you search for new repositories and add/remove them from yout local storage.
struct SearchMenuView: View {
    
    @StateObject var searchMenuViewModel: SearchMenuViewModel = SearchMenuViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                exploreTab.tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                localTab.tabItem {
                    Image(systemName: "folder.fill")
                    Text("Local")
                }
            }
            .navigationTitle("GH Kanban")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        searchMenuViewModel.addMockData()
                    } label: {
                        Text("Add")
                    }

                }
            }
        }
    }
}

fileprivate extension SearchMenuView {
    
    /// This tab shows all the Repositories from a given User
    var exploreTab: some View {
        List {
//            ForEach(mockRepos) { repository in
//                repositoryExplorerCell(repo: repository)
//            }
        }
        .listStyle(.plain)
    }
    
    /// This tab shows all the locally stored Repositories
    var localTab: some View {
        List {
            ForEach(self.searchMenuViewModel.storedRepositories) { repository in
                repositoryKanbanCell(repo: repository)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    self.searchMenuViewModel.removeRepository(index: index)
                }
            }
        }
        .listStyle(.plain)
    }
    
    func repositoryExplorerCell(repo: Repository) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("**\(repo.wrappedName)**")
                Text("*\(repo.wrappedAuthor)*")
            }
            Spacer()
            // !!!: Button should not be shown if repo is already stored
            if !self.searchMenuViewModel.storedRepositories.contains(where: { storedRepo in storedRepo == repo }) {
                Button {
//                    self.searchMenuViewModel.storeRepository(repository: repo)
                } label: {
                    Image(systemName: "folder.fill.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(.blue)
                }
            }

        }
        .padding(.vertical, 10)
    }
    
    func repositoryKanbanCell(repo: Repository) -> some View {
        NavigationLink {
            KanbanView(repository: repo)
        } label: {
            VStack(alignment: .leading, spacing: 3) {
                Text("**\(repo.wrappedName)**")
                Text("*\(repo.wrappedAuthor)*")
            }
        }
    }
    
}

struct SearchMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMenuView()
    }
}
