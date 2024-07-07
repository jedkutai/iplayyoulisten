//
//  HistoryAlbumCell.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 7/5/24.
//

import SwiftUI
import Kingfisher

struct HistoryAlbumCell: View {
    let album: AlbumModel
    
    let cellDimension: CGFloat = UIScreen.main.bounds.width / 4
    
    var body: some View {
        KFImage(URL(string: album.artworkUnblurredUrl ?? album.artworkUrl))
            .placeholder {
                ProgressView()
                    .frame(maxWidth: cellDimension, maxHeight: cellDimension)
            }
            .resizable()
            .scaledToFit()
            .frame(maxWidth: cellDimension, maxHeight: cellDimension)
    }
}
