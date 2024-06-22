//
//  SampleAlbumView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/20/24.
//

import SwiftUI

struct SampleAlbumView: View {
    let album: AlbumModel = AlbumModel.albums[0]
    
    var body: some View {
        VStack {
            DisplayAlbumGenreAndYear(genre: album.genre, year: album.releaseYear)
            
            DisplayArtwork(artworkUrl: album.artworkUrl)
                .shadow(radius: 5)
    
            DisplayAlbumTitle(title: album.title)
            
            PuzzleHint(artistName: album.artist)
                .padding(.top)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
        )
    }
}

#Preview {
    SampleAlbumView()
}
