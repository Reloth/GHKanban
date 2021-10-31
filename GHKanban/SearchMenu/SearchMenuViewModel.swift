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
    
    func storeRepository(repository: Repository) {
        self.storedRepositories.append(repository)
    }
    
    func removeRepository(index: Int) {
        self.storedRepositories.remove(at: index)
    }
}
