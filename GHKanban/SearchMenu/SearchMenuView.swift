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
            .task {
                await searchMenuViewModel.loadRepos()
            }
        }
    }
}

fileprivate extension SearchMenuView {
    
    /// This tab shows all the public Repositories from Github
    var exploreTab: some View {
        List {
            ForEach(self.searchMenuViewModel.searchedRepositories, id: \.self) { repository in
                repositoryExplorerCell(repository: repository)
                    .task {
                        if repository == self.searchMenuViewModel.searchedRepositories.last {
                            await self.searchMenuViewModel.loadRepos()
                        }
                    }
            }
        }
        .refreshable {
            await self.searchMenuViewModel.refreshSearchedRepos()
        }
        .listStyle(.plain)
    }
    
    /// This tab shows all the locally stored Repositories
    var localTab: some View {
        List {
            ForEach(self.searchMenuViewModel.storedRepositories) { repository in
                repositoryKanbanCell(repository: repository)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    self.searchMenuViewModel.removeRepository(index: index)
                }
            }
        }
        .listStyle(.plain)
    }
    
    /// Cell for the explore tab, the add to local button is hidden if the Repository is already stored
    func repositoryExplorerCell(repository: RepositoryResponse) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("**\(repository.name)**")
                Text("*\(repository.author)*")
            }
            Spacer()
            // !!!: Button should not be shown if repo is already stored
            if !self.searchMenuViewModel.storedRepositories.contains(where: { storedRepo in
                debugPrint("searchRepos: \(repository.idNum) -- storedRepo: \(storedRepo.idNum)")
                return storedRepo.idNum == repository.idNum }) {
                Button {
                    Task.init {
                        await self.searchMenuViewModel.storeRepository(repository: repository)
                    }
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
    
    /// Cell for the local tab, gets you to the Kanban on tap
    func repositoryKanbanCell(repository: Repository) -> some View {
        NavigationLink {
            KanbanView(repository: repository)
        } label: {
            VStack(alignment: .leading, spacing: 3) {
                Text("**\(repository.wrappedName)**")
                Text("*\(repository.wrappedAuthor)*")
            }
        }
    }
    
}

struct SearchMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMenuView()
    }
}
