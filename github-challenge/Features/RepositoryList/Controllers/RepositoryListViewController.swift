
import UIKit

class RepositoryListViewController: UIViewController {
    
    private var viewModel: RepositoryViewModel
    private var refresh = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: RepositoryViewModel = RepositoryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.initViewModel()
        self.configureTableView()
        self.viewModel.fetchRepositories(reload: true)
    }
    
    private func initialize() {
        self.configureViews()
        self.insertViews()
        self.setupConstraints()
    }
    
    private func initViewModel() {
        self.viewModel.showAlert = { success, message in
            DispatchQueue.main.async {
                Alert.banner(message, state: success ? .success : .error)
            }
        }
        
        self.viewModel.updateTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.endRefreshing = { [weak self] in
            DispatchQueue.main.async {
                self?.refresh.endRefreshing()
            }
        }
        
        self.viewModel.startRefreshing = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.refresh.beginRefreshing()
                self.tableView.setContentOffset(CGPoint(x: 0, y: -self.refresh.frame.size.height), animated: true)
            }
        }
    }
    
    private func configureViews() {
        self.title = self.viewModel.navigationTitle
        self.view.backgroundColor = .white
        self.refresh.standard(self, action: #selector(self.handleRefresh))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func insertViews() {
        self.view.addSubview(self.tableView)
    }
    
    private func setupConstraints() {
        self.tableView
            .topAnchor(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            .leadingAnchor(equalTo: self.view.leadingAnchor)
            .trailingAnchor(equalTo: self.view.trailingAnchor)
            .bottomAnchor(equalTo: self.view.bottomAnchor)
    }
    
    private func configureTableView() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 32.0, right: 0.0)
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.register(RepositoryCell())
        self.tableView.addSubview(self.refresh)
    }
    
    @objc func handleRefresh() {
        self.viewModel.fetchRepositories(reload: true)
    }
    
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.viewModel.sections[section]
        return section.numberOfRows(self.viewModel)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.viewModel.sections[indexPath.section]
        let identifier = section.cellIdentifier(self.viewModel, indexPath: indexPath)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let item = self.viewModel.items[indexPath.row]
        
        if let cell = cell as? Reusable {
            cell.setup(item)
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        let end = endScrolling >= (scrollView.contentSize.height - 500)
        
        if end, !self.viewModel.isLoading, !self.viewModel.eof {
            self.viewModel.fetchRepositories()
        }
    }
    
}
