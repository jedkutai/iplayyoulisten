//
//  DisplayAlbumTitle.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI

struct DisplayAlbumTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title.weight(.bold))
            .foregroundStyle(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
}

#Preview {
    DisplayAlbumTitle(title: "Album Title")
}
