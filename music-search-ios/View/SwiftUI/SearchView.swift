//
//  SearchView.swift
//  music-search-ios
//
import SwiftUI

// MARK:- Main Screen
struct SearchView: View {
	@ObservedObject private var viewModel = SearchViewModel()
	
	var body: some View {
		VStack {
			SearchBarView(searchText: $viewModel.searchText)
			if viewModel.songs.isEmpty {
				EmptyStateView()
			} else {
				ScrollView {
					LazyVGrid(columns: [GridItem()]) {
						ForEach(viewModel.songs) { song in
							SongItemView(song: song)
						}
					}
				}
			}
		}.navigationTitle("SwiftUI")
	}
}

// MARK:- Single Song Item View
struct SongItemView: View {
	var song: SongModel
	
	var body: some View {
		HStack(alignment: .top, spacing: 16) {
			AsyncImageView(asyncImage: AsyncImage(url: URL(string: song.artworkUrl100 ?? "")!))
			VStack(alignment: .leading, spacing: 4) {
				Text(song.trackName ?? "n/a")
					.foregroundColor(.primary)
					.font(.headline)
				Text(song.artistName ?? "n/a")
					.font(.subheadline)
					.foregroundColor(.secondary)
					.multilineTextAlignment(.leading)
					.lineLimit(2)
					.frame(height: 40)
			}
			Spacer()
		}.padding(.horizontal)
	}
}

// MARK:- Empty State View
struct EmptyStateView: View {
	var body: some View {
		VStack {
			Spacer()
			Image(systemName: "music.note")
				.font(.system(size: 100))
				.padding(.bottom)
			Text("Tell us about your music taste through text")
				.font(.title)
				.multilineTextAlignment(.center)
			Spacer()
		}
		.padding()
		.foregroundColor(Color(.systemPink))
	}
}

// MARK:- Search Bar View
struct SearchBarView: UIViewRepresentable {
	typealias UIViewType = UISearchBar
	@Binding var searchText: String
	
	func makeUIView(context: Context) -> UISearchBar {
		let searchBar = UISearchBar(frame: .zero)
		searchBar.delegate = context.coordinator
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = "Search any song, movie or series..."
		return searchBar
	}
	
	func updateUIView(_ uiView: UISearchBar, context: Context) {}
	
	func makeCoordinator() -> SearchBarCoordinator {
		return SearchBarCoordinator($searchText)
	}
	
	class SearchBarCoordinator: NSObject, UISearchBarDelegate {
		@Binding var searchText: String
		
		init(_ searchText: Binding<String>) {
			self._searchText = searchText
		}
		
		func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
			self.searchText = searchText
		}
		
		func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
			searchBar.resignFirstResponder()
		}
	}
}

// MARK:- Preview
struct SearchView_Previews: PreviewProvider {
	static var previews: some View {
		SearchView()
	}
}
