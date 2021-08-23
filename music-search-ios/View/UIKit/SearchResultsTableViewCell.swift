//
//  SearchResultsTableViewCell.swift
//  music-search-ios
//

import UIKit
import SwiftUI

class SearchResultsTableViewCell: UITableViewCell {
	// MARK:- IBOutlets
	@IBOutlet weak var thumbnailImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var artistLabel: UILabel!
	
	// MARK:- Variables
	static let identifier = "SearchResultsTableViewCell"
	
	// MARK:- Cell UI Setup
	func setUpCell(withSong song: SongModel) {
		titleLabel.text = song.trackName
		artistLabel.text = song.artistName
		let urlString = song.artworkUrl100 ?? ""
		guard let url = URL(string: urlString) else { return }
		DispatchQueue.global(qos: .background).async {
			URLSession.shared.dataTask(with: url) { (data, response, error) in
				if error != nil { return }
				guard let data = data else { return }
				let image = UIImage(data: data)
				DispatchQueue.main.async {
					self.thumbnailImageView.image = image
				}
			}.resume()
		}
		// Tried loading SwiftUI view in UIKit view.
		//		let asyncImageModel = AsyncImage(url: url)
		//		let asyncImage = AsyncImageView(asyncImage: asyncImageModel)
		//		let uiKitImageView = UIHostingController(rootView: asyncImage)
	}
}
