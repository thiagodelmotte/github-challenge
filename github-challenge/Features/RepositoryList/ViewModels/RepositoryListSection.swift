
import UIKit

protocol RepositoryListSectionProtocol {
    func cellIdentifier(_ viewModel: RepositoryViewModel, indexPath: IndexPath) -> String
    func numberOfRows(_ viewModel: RepositoryViewModel) -> Int
}

class RepositoryListSection: RepositoryListSectionProtocol {
    
    func cellIdentifier(_ viewModel: RepositoryViewModel, indexPath: IndexPath) -> String {
        return RepositoryCell.reuseIdentifier
    }
    
    func numberOfRows(_ viewModel: RepositoryViewModel) -> Int {
        return viewModel.items.count
    }
    
}
