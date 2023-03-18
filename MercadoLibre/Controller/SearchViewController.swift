//
//  SearchViewController.swift
//  MercadoLibre
//
//  Created by Lazaro Hernandez on 12/3/23.
//

import UIKit

class SearchViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var items = [ResultModel]()
    var searchManager = SearchManager()
    var currentSearch = ""
    var offset = 0
    var limit = 10
    var paging: Paging?
    
    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.delegate = self
        
        setupTableView()
        setupSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ResultTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ResultTableViewCell.identifier)
        tableView.isHidden = true
    }
    
    func setupSearch() {
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }
    
}

// MARK: - Extensions
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath)
        if let cell = cell as? ResultTableViewCell {
            let item = items[indexPath.row]
            cell.setupCell(with: item)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == items.count && items.count > 9 && self.items.count < self.paging?.total ?? 0 {
            offset += 10
            let limitNew = self.items.count + limit > self.paging?.total ?? 0 ? (self.paging?.total ?? 0) - self.items.count : limit
            searchManager.featchSearch(with: currentSearch, offset: offset, limit: limitNew)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController.instantiate(storyboardName: "Main")
        detailVC.result = items[indexPath.row]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension SearchViewController: SearchManagerDelegate {
    
    func didUpdateSearch(_ searchrManager: SearchManager, result: [ResultModel], paging: Paging) {
        self.paging = paging
        items += result
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let text = searchBar.text, !text.isEmpty {
            items = []
            searchManager.featchSearch(with: text, offset: 0, limit: limit)
            currentSearch = text
            tableView.reloadData()
        } else {
            searchBar.placeholder = "Please enter a product"
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden =  false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        tableView.isHidden = true
        offset = 0
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.placeholder = "Find your wishes..."
        items = []
        tableView.reloadData()
    }
    
}

