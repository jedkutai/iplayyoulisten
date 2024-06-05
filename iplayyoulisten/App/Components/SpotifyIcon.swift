//
//  SpotifyIcon.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI

struct SpotifyIcon: View {
    var body: some View {
        Image("spotify icon")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
    }
}

#Preview {
    SpotifyIcon()
}
