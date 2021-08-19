//
//  ITunesClient.swift
//  music-search-ios
//
//  Created by sanjeev on 17/08/21.
//

import Foundation
import Combine

class ITunesClient {
	
	private init() {}
	static let shared = ITunesClient()
	private let baseUrlString = "https://itunes.apple.com/search/"
	private var store = Set<AnyCancellable>()
	
	func getSearchResults(for key: String) -> Future<[SongModel], Error> {
		return Future<[SongModel], Error> { [unowned self] promise in
			guard var urlComponents = URLComponents(string: baseUrlString) else {
				promise(.failure(NetworkError.invalidUrl))
				return
			}
			urlComponents.queryItems = [URLQueryItem(name: "term", value: key)]
			guard let url = urlComponents.url else {
				promise(.failure(NetworkError.invalidUrl))
				return
			}
			URLSession.shared.dataTaskPublisher(for: url).tryMap { (data, response) -> Data in
				guard let httpResponse = response as? HTTPURLResponse, 200 ..< 400 ~= httpResponse.statusCode else {
					throw NetworkError.requestFailed
				}
				return data
			}
			.decode(type: SearchResponseModel.self, decoder: JSONDecoder())
			.receive(on: RunLoop.main)
			.sink(receiveCompletion: { completion in
				if case let .failure(error) = completion {
					switch error {
					case let decodingError as DecodingError:
						promise(.failure(decodingError))
					default:
						promise(.failure(error))
					}
				}
			}, receiveValue: { promise(.success($0.results)) })
			.store(in: &self.store)
			
		}
	}
	
}

enum NetworkError: Error {
	case invalidUrl
	case requestFailed
}
