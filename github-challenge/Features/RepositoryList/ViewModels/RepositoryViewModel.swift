
import Foundation
import UIKit

class RepositoryViewModel {
    
    private var repository: Repository
    private var repositories: [Repository]?
    
    var firstLoad = true
    var isLoading = false
    var eof = false
    var currentPage = 1
    
    init(repository: Repository = Repository()) {
        self.repository = repository
        self.isLoading = false
        self.eof = false
        self.firstLoad = true
    }
    
    var showAlert: ((Bool, String)->())?
    var updateTableView: (()->())?
    var endRefreshing: (()->())?
    var startRefreshing: (()->())?
    
    var name: String? {
        return self.repository.name
    }
    
    var stars: String {
        return "\(self.repository.stargazers_count ?? 0)"
    }
    
    var ownerName: String? {
        return self.repository.owner?.login
    }
    
    var ownerAvatarUrl: URL? {
        return URL(string: self.repository.owner?.avatar_url ?? "")
    }
    
    var navigationTitle: String {
        return "listTitle".localized()
    }
    
    var sections: [RepositoryListSection] {
        return [RepositoryListSection()]
    }
    
    var items: [RepositoryViewModel] {
        guard let repositories = self.repositories else {
            return []
        }
        return repositories.map {
            RepositoryViewModel(repository: $0)
        }
    }
    
    func fetchRepositories(reload: Bool = false) {
        guard !self.isLoading else { return }
        self.isLoading = true
        
        if self.firstLoad {
            self.startRefreshing?()
            self.firstLoad = false
        }
        
        SearchApi.fetch(self.currentPage, success: { [weak self] search in
            if reload {
                self?.eof = false
                self?.repositories = search.items
            } else if let items = search.items, items.count > 0 {
                self?.repositories?.append(contentsOf: items)
                self?.currentPage += 1
            } else {
                self?.eof = true
            }
            
            self?.endRefreshing?()
            self?.updateTableView?()
            self?.isLoading = false

        }) { [weak self] (code, error, response) in
            self?.showAlert?(false, "apiErrorMessage".localized())
            self?.endRefreshing?()
            self?.isLoading = false
        }
    }
    
}
