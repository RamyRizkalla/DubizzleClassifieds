//  Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

class ClassifiedsListViewController: UIViewController {
    private var viewModel: ClassifiedsListViewModel!
    private var alerthandler: AlertHandler!
    private var activityIndicator = UIActivityIndicatorView(style: .medium)

    @IBOutlet private var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }

    private var refreshControl: UIRefreshControl? {
        return tableView.refreshControl
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initModels()
        configureNavigationBar()
        tableView.addActivityIndicator(activityIndicator)
        fetchClassifiedsList()
    }

    private func initModels() {
        viewModel = ClassifiedsListViewModel()
        alerthandler = AlertHandler(presentingViewCtrl: self)
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = Colors.themeRed
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        title = L10n.ClassifiedsList.screenTitle
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerCell(ofType: ClassifiedsListTableViewCell.self)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self, action: #selector(fetchClassifiedsList),
            for: .valueChanged
        )
    }

    @objc
    private func fetchClassifiedsList() {
        activityIndicator.startAnimating()
        viewModel.fetchClassifiedsList { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showError(error)
                } else {
                    self?.tableView.reloadData()
                }
                self?.activityIndicator.stopAnimating()
                self?.refreshControl?.endRefreshing()
            }
        }
    }

    private func showError(_ error: DError) {
        alerthandler.showInformation(
            title: L10n.Global.Titles.error,
            message: error.message
        )
    }
}

extension ClassifiedsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.list.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureItemCell(tableView, at: indexPath)
    }

    private func configureItemCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: ClassifiedsListTableViewCell = tableView.dequeueCell(for: indexPath)
        let classifed = viewModel.list[indexPath.row]

        let model = ClassifiedsListTableViewCellData(
            name: classifed.name,
            price: classifed.price,
            iconPath: classifed.imageUrlsThumbnails[0]
        )
        cell.model = model
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewCtrl = ClassifiedDetailsViewController.instantiate(from: "ClassifiedDetails")
        detailsViewCtrl.viewModel = ClassifiedDetailsViewModel(model: viewModel.list[indexPath.row])
        navigationController?.pushViewController(detailsViewCtrl, animated: true)
    }
}

extension ClassifiedsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
