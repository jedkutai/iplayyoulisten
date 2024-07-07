//
//  ResultCell.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/20/24.
//

import SwiftUI
import Kingfisher

struct ResultCell: View {
    let album: AlbumModel
    let correct: Bool
    
    let iconDimension: CGFloat = UIScreen.main.bounds.height / 16
    var body: some View {
        HStack {
            KFImage(URL(string: album.artworkUnblurredUrl ?? album.artworkUrl))
                .placeholder {
                    ProgressView()
                        .frame(width: iconDimension, height: iconDimension)
                }
                .resizable()
                .scaledToFit()
                .frame(width: iconDimension, height: iconDimension)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 5)
            
            Text(album.title)
                .font(.title.weight(.bold))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            
            Spacer()
            
            VStack {
                Link(destination: URL(string: album.appleMusicLink)!, label: {
                    AppleMusicIcon()
                        .frame(width: iconDimension / 2, height: iconDimension / 2)
                })
                
                Link(destination: URL(string: album.spotifyLink)!, label: {
                    SpotifyIcon()
                        .frame(width: iconDimension / 2, height: iconDimension / 2)
                })
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
        )
    }
}

//#Preview {
//    ResultCell()
//}
