//
//  DisplayArtwork.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI
import Kingfisher

struct DisplayArtwork: View {
    let artworkUrl: String
    var body: some View {
        KFImage(URL(string: artworkUrl))
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    DisplayArtwork(artworkUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FA%24AP%20Ferg%20ALWAYS%20STRIVE%20AND%20PROS.webp?alt=media&token=b04b7840-3795-46ff-9af3-1297b7c46c0f")
}
