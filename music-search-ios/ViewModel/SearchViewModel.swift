//
//  SearchViewModel.swift
//  music-search-ios
//
import Foundation
import Combine

class SearchViewModel: ObservableObject {
	private var store = Set<AnyCancellable>()
	@Published var songs = [SongModel]()
	@Published var searchText = ""
	
	init() {
		self.$searchText.sink { [weak self] text in
			if !text.isEmpty {
				self?.searchSongs(with: text)
			}
		}.store(in: &store)
	}
	
	func searchSongs(with key: String, completionHandler: (([SongModel]) -> Void)? = nil) {
		ITunesClient.shared.getSearchResults(for: key)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .failure(let error):
					print("something went wrong \(error.localizedDescription)")
				default:
					print("default")
				}
			}, receiveValue: { [weak self] songs in
				self?.songs = songs
				completionHandler?(songs)
			})
			.store(in: &store)
	}
}
