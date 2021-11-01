//
//  SearchMenuViewModel.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import Foundation

/// This ViewModel is used to manage all necessary variables and functions for a SearchMenuView to operate, and also for retrieving and storing the Repositories and Issues.
class SearchMenuViewModel: ObservableObject {
    
    @Published var searchedRepositories: [RepositoryResponse] = []
    @Published var storedRepositories: [Repository] = []
    
    var offset: Int = 0
    
    init() {
        self.getStoredRepos()
    }
    
    func storeRepository(repository: RepositoryResponse) async {
        do {
            try await self.getIssuesFromRepo(repository: repository)
        }
        catch {
            debugPrint("error downloading issues - \(error)")
        }
    }
    
    func removeRepository(index: Int) {
        PersistenceController.shared.deleteRepository(repository: storedRepositories[index])
        self.getStoredRepos()
    }
    
    func getStoredRepos() {
        DispatchQueue.main.async {
            self.storedRepositories = PersistenceController.shared.getAllRepositories()
                .sorted {
                    $0.wrappedAuthor < $1.wrappedAuthor
                }
        }
    }
    
    func refreshSearchedRepos() async {
        self.offset = 0
        self.searchedRepositories.removeAll()
        await self.loadRepos()
    }
    
    func loadRepos() async {
        do {
            try await reposAsyncLoad()
        }
        catch {
            debugPrint("error downloading repos - \(error)")
        }
    }
    
    func reposAsyncLoad() async throws {
        let url = URL(string: "https://api.github.com/repositories?since=\(offset)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { return }
        
        guard let decoded = try? JSONDecoder().decode([RepositoryResponse].self, from: data)
        else { return }
        
        if let newOffset = decoded.last?.idNum {
            self.offset = newOffset
        }
        
        DispatchQueue.main.async {
            self.searchedRepositories.append(contentsOf: decoded)
        }
    }
    
    func getIssuesFromRepo(repository: RepositoryResponse) async throws {
        let url = URL(string: "https://api.github.com/repos/\(repository.author)/\(repository.name)/issues")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { return }
        
        guard let decoded = try? JSONDecoder().decode([IssueResponse].self, from: data)
        else { return }
        
        let newRepository = Repository(context: PersistenceController.shared.viewContext)
        newRepository.name = repository.name
        newRepository.author = repository.author
        newRepository.idNum = Int32(repository.idNum)
        
        decoded.forEach { issueResponse in
            let newIssue = Issue(context: PersistenceController.shared.viewContext)
            newIssue.title = issueResponse.title
            newIssue.info = issueResponse.body
            newIssue.position = 0
            newIssue.idNum = Int32(issueResponse.idNum)
            newIssue.parentRepository = newRepository
        }
        PersistenceController.shared.save()
        self.getStoredRepos()
    }
    
}
