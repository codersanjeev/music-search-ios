//
//  SearchViewController.swift
//  music-search-ios
//
import UIKit

class SearchViewController: UIViewController {
	// MARK:- IBOutlets
	@IBOutlet weak var searchTableView: UITableView!
	
	// MARK:- Variables
	private var viewModel: SearchViewModel?
	private var dataSource = [SongModel]()
	
	// MARK:- Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = SearchViewModel()
		self.title = "UIKit"
	}
}

// MARK:- Table View DataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let searchTableViewCell = tableView.dequeueReusableCell(
			withIdentifier: SearchResultsTableViewCell.identifier,
			for: indexPath) as? SearchResultsTableViewCell {
			searchTableViewCell.setUpCell(withSong: dataSource[indexPath.row])
			return searchTableViewCell
		}
		return UITableViewCell()
	}
		
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(100)
	}
}

// MARK:- Search Delegate Handling
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel?.searchSongs(with: searchText) { [weak self] response in
			self?.dataSource = response
			DispatchQueue.main.async {
				self?.searchTableView.reloadData()
			}
		}
	}
}
