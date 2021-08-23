//
//  AsyncImage.swift
//  music-search-ios
//
import SwiftUI
import UIKit
import Combine

final class AsyncImage: ObservableObject {
	private static let _cache = NSCache<AnyObject, UIImage>()
	private let url: URL
	@Published var image: UIImage? = nil
	
	init(url: URL) {
		self.url = url
	}
	
	public func loadImage() {
		let cacheKey = url.absoluteString
		if let cachedImage = AsyncImage._cache.object(forKey: cacheKey as AnyObject) {
			self.image = cachedImage
			return
		}
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self = self else { return }
			do {
				let data = try Data(contentsOf: self.url)
				guard let image = UIImage(data: data) else { return }
				AsyncImage._cache.setObject(image, forKey: cacheKey as AnyObject)
				DispatchQueue.main.async { self.image = image }
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}
