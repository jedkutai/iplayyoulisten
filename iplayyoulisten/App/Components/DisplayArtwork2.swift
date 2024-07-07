//
//  DisplayArtwork2.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/24/24.
//

import SwiftUI
import Kingfisher

struct DisplayArtwork2: View {
    let artworkUrl: String
    var artworkUnblurredUrl: String?
    let showUnblurred: Bool
    
    var body: some View {
        if showUnblurred {
            KFImage(URL(string: artworkUnblurredUrl ?? artworkUrl))
                .placeholder {
                    ProgressView("Poor Connection")
                }
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            KFImage(URL(string: artworkUrl))
                .placeholder {
                    ProgressView("Poor Connection")
                }
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
}

#Preview {
    DisplayArtwork2(artworkUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FA%24AP%20Ferg%20ALWAYS%20STRIVE%20AND%20PROS.webp?alt=media&token=b04b7840-3795-46ff-9af3-1297b7c46c0f", artworkUnblurredUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2Fa%24ap%20ferg%20unblurred%20always%20strive.webp?alt=media&token=e8636b27-d8ca-4cd4-a0f6-ee411ed96124", showUnblurred: false)
}
