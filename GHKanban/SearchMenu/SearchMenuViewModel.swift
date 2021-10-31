//
//  SearchMenuViewModel.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import Foundation

/// This ViewModel is used to manage all necessary variables and functions for a SearchMenuView to operate (and later will be used to store locally the selected Repositories).
class SearchMenuViewModel: ObservableObject {
    
    @Published var storedRepositories: [Repository] = []
    
    init() {
        self.getStoredRepos()
    }
    
//    func storeRepository(repository: Repository) {
//        self.storedRepositories.append(repository)
//    }
    
    func removeRepository(index: Int) {
        PersistenceController.shared.deleteRepository(repository: storedRepositories[index])
        self.getStoredRepos()
    }
    
    func getStoredRepos() {
        self.storedRepositories = PersistenceController.shared.getAllRepositories()
            .sorted {
                $0.wrappedAuthor < $1.wrappedAuthor
            }
    }
    
}

extension SearchMenuViewModel {
    func addMockData() {
        let firstRepo = Repository(context: PersistenceController.shared.viewContext)
        firstRepo.name = "Third repo"
        firstRepo.author = "Diego"
        
        let R1_01 = Issue(context: PersistenceController.shared.viewContext)
        R1_01.title = "R3_01"
        R1_01.info = "Something"
        R1_01.position = 3
        R1_01.id = UUID()
        R1_01.parentRepository = firstRepo
        
        let R1_02 = Issue(context: PersistenceController.shared.viewContext)
        R1_02.title = "R3_02"
        R1_02.info = "Ugly colors"
        R1_02.position = 0
        R1_02.id = UUID()
        R1_02.parentRepository = firstRepo
        
        
        let secondRepo = Repository(context: PersistenceController.shared.viewContext)
        secondRepo.name = "Second repo"
        secondRepo.author = "Diego"
        
        let R2_01 = Issue(context: PersistenceController.shared.viewContext)
        R2_01.title = "R2_01"
        R2_01.info = "App crashes on load"
        R2_01.position = 3
        R2_01.id = UUID()
        R2_01.parentRepository = secondRepo
        
        let R2_02 = Issue(context: PersistenceController.shared.viewContext)
        R2_02.title = "R2_02"
        R2_02.info = "Ugly colors"
        R2_02.position = 0
        R2_02.id = UUID()
        R2_02.parentRepository = secondRepo
        
        PersistenceController.shared.save()
        self.getStoredRepos()
    }
}
