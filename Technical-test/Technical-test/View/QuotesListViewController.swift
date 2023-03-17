//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: UIViewController {
    
    // MARK: - Private properties
    private let dataManager = DataManager()
    private var market: Market?
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        setupTableView()
        setupActivityIndicator()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchData() {
        activityIndicator.startAnimating()
        dataManager.fetchQuotes { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch result {
                case .success(let quotes):
                    self.activityIndicator.stopAnimating()
                    self.market = Market()
                    self.market?.quotes = quotes
                    self.tableView.reloadData()
                case .failure(let error):
                    self.activityIndicator.stopAnimating()
                    print("Error: \(error)")
                }
            }
        }
    }
    
    private func showDetail(for qoute: Quote) {
        let qouteDetailsViewController = QuoteDetailsViewController(quote: qoute)
        navigationController?.pushViewController(qouteDetailsViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource implementation
extension QuotesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard market?.quotes != nil else {
            tableView.setEmptyMessage("No Data found")
            return 0
        }
        
        tableView.restore()
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = market?.quotes?.count {
            return count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? QuoteTableViewCell,
              let quotes = market?.quotes else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let quote = quotes[indexPath.row]
        let subtitle = quote.last.notNil + " " + quote.currency.notNil
        
        let isFavourite: Bool
        if let nameList = UserDefaults.standard.array(forKey: "quoteNameArray") as? [String], nameList.contains(quote.name.notNil) {
            isFavourite = true
        } else {
            isFavourite = false
        }
        
        cell.configure(title: quote.name,
                       subtitle: subtitle,
                       changeRate: quote.readableLastChangePercent,
                       isFavourite: isFavourite,
                       rateColor: quote.variationColor)
        return cell
    }
}

// MARK: - UITableViewDelegate implementation
extension QuotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let quotes = market?.quotes else { return }
        showDetail(for: quotes[indexPath.row])
    }
}
