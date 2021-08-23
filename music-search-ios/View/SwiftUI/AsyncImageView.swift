//
//  AsyncImageView.swift
//  music-search-ios
//
import SwiftUI

struct AsyncImageView: View {
	@State var asyncImage: AsyncImage
	
    var body: some View {
		ZStack {
			if let image = asyncImage.image {
				Image(uiImage: image)
					.resizable()
					.renderingMode(.original)
					.frame(width: 75, height: 75)
					.cornerRadius(8)
					.shadow(radius: 8)
			} else {
				Rectangle()
					.foregroundColor(.gray)
					.frame(width: 75, height: 75)
					.cornerRadius(8)
					.shadow(radius: 8)
			}
		}.onAppear {
			asyncImage.loadImage()
		}
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(asyncImage: AsyncImage(url: URL(string: "")!))
    }
}
