//
//  MusicController.swift
//  iOSArchitecturesDemo
//
//  Created by Крылов Данила  on 02.12.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class MusicSearchController: UIViewController, MusicSearchViewInput  {

    private var searchView: SearchView {
        return self.view as! SearchView
    }

    var searchResults = [SongCellModel]() {
        didSet {
            self.searchView.searchBar.resignFirstResponder()
            self.searchView.tableView.isHidden = self.searchResults.isEmpty
            self.searchView.tableView.reloadData()
        }
    }

    var output: MusicSearchViewOutput!

    private struct Constants {
        static let reuseID = "cell"
    }

//MARK: -Life Cycle

    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseID)
    }


//MARK: - MusicSearchViewInput
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }

    func setModels(_ cellModels: [SongCellModel]) {
        self.searchResults = cellModels
        self.searchView.tableView.reloadData()
        self.searchView.tableView.isHidden = false
        self.searchView.searchBar.resignFirstResponder()
    }

    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }

    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }

}

//MARK: - UITableViewDelegate

extension MusicSearchController: UITableViewDelegate {

}

//MARK: - UITableViewDataSource

extension MusicSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseID, for: indexPath) as?
                SongCell else { return UITableViewCell() }
        let song = searchResults[indexPath.row]
        cell.configure(songModel: song)
        return cell
    }

}

//MARK: - UISearchBarDelegate


extension MusicSearchController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }

        self.output.viewDidSearch(with: query)
    }

}
