//
//  SampleAlbumView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/20/24.
//

import SwiftUI

struct SampleAlbumView: View {
    let album: AlbumModel = AlbumModel.albums[0]
    @State private var unblur: Bool = false
    
    var body: some View {
        VStack {
            DisplayAlbumGenreAndYear(genre: album.genre, year: album.releaseYear)
            
//            DisplayArtwork(artworkUrl: album.artworkUrl)
//                .shadow(radius: 5)
            
            Button {
                unblur.toggle()
            } label: {
                DisplayArtwork2(artworkUrl: album.artworkUrl, artworkUnblurredUrl: album.artworkUnblurredUrl, showUnblurred: unblur)
                    .shadow(radius: 5)
            }
    
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
