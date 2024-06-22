//
//  DisplayAlbumGenreAndYear.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI

struct DisplayAlbumGenreAndYear: View {
    let genre: String
    let year: Int
    
    var body: some View {
        Text("\(genre.uppercased()) • \(year.description)")
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
}

#Preview {
    DisplayAlbumGenreAndYear(genre: "Alternative", year: 2024)
}
