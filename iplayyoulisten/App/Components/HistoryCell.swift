//
//  HistoryCell.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI
import Kingfisher

struct HistoryCell: View {
    let songOfTheDay: SongOfTheDay
    let maxArtworkHeight: CGFloat = 50
    let iconDimension: CGFloat = 30
    
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
//            Text("\(songOfTheDay.id)")
//                .font(.subheadline)
//                .foregroundStyle(Color(.systemGray))
//                .frame(width: 30)
            Group {
                if let artwork = songOfTheDay.artwork {
                    KFImage(URL(string: artwork))
                        .placeholder {
                            ProgressView()
                                .frame(maxWidth: maxArtworkHeight, maxHeight: maxArtworkHeight)
                                
                        }
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(maxHeight: maxArtworkHeight)
                } else {
                    Image(systemName: "questionmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: maxArtworkHeight)
                        .foregroundStyle(Color(.systemGray))
                }
            }
            .foregroundStyle(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                if let title = songOfTheDay.title {
                    HStack {
                        Text(title)
                            .fontWeight(.semibold)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        if let explicit = songOfTheDay.explicit {
                            if explicit {
                                ExplicitTag()
                                    .frame(width: 15)
                            }
                        }
                    }
                }
                
                if let album = songOfTheDay.album {
                    Text(album)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    HistoryCell(songOfTheDay: SongOfTheDay.song)
}
