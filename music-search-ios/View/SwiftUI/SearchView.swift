//
//  SearchView.swift
//  music-search-ios
//
//  Created by sanjeev on 18/08/21.
//

import SwiftUI

struct SearchView: View {
	
	var songs = ["a", "b", "c", "d", "e"]
	
    var body: some View {
		VStack {
			
			LazyVGrid(columns: [GridItem()]) {
				ForEach(songs, id: \.self) { song in
					Text(song)
				}
			}
		}
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
