//
//  AppleMusicIcon.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI

struct AppleMusicIcon: View {
    var body: some View {
        Image("apple music icon")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 50, height: 50)
    }
}

#Preview {
    AppleMusicIcon()
}
