//
//  SearchResponseModel.swift
//  music-search-ios
//
//  Created by sanjeev on 17/08/21.
//

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Codable,Hashable {
	let resultCount: Int
	let results: [SongModel]
}

// MARK: - SongModel
struct SongModel: Codable, Hashable, Identifiable {
	let wrapperType, kind: String?
	let id: Int
	let artistID, collectionID: Int?
	let collectionName,collectionCensoredName: String?
	var artistName, trackName: String?
	let trackCensoredName: String?
	let artistViewURL, collectionViewURL, trackViewURL: String?
	let previewURL: String?
	let artworkUrl30, artworkUrl60, artworkUrl100: String?
	let collectionPrice: Double?
	let trackPrice: Double?
	let releaseDate: String
	let collectionExplicitness, trackExplicitness: String?
	let discCount: Int?
	let discNumber, trackCount, trackNumber: Int?
	let trackTimeMillis: Int?
	let country, currency, primaryGenreName: String?
	let isStreamable: Bool?
	
	enum CodingKeys: String, CodingKey {
		case wrapperType, kind
		case artistID = "artistId"
		case collectionID = "collectionId"
		case id = "trackId"
		case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
		case artistViewURL = "artistViewUrl"
		case collectionViewURL = "collectionViewUrl"
		case trackViewURL = "trackViewUrl"
		case previewURL = "previewUrl"
		case artworkUrl30, artworkUrl60, artworkUrl100,collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
	}
}

