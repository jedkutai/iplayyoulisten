//
//  DisplaySongCell.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI
import Kingfisher

struct DisplaySongCell: View {
    let songOfTheDay: SongOfTheDay
    
    let maxArtworkHeight: CGFloat = UIScreen.main.bounds.width
    let iconDimension: CGFloat = 50
    
    @State private var showDetails = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            if let artist = songOfTheDay.artist{
                Text(artist)
                    .font(.title.weight(.bold))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
            
            Button {
                if songOfTheDay.details != nil {
                    showDetails.toggle()
                }
            } label: {
                VStack {
                    if let artwork = songOfTheDay.artwork {
                        KFImage(URL(string: artwork))
                            .placeholder {
                                ProgressView()
                                    .frame(maxWidth: maxArtworkHeight, maxHeight: maxArtworkHeight)
                                    
                            }
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
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
                .shadow(radius: 10)
            }
            
            if let title = songOfTheDay.title {
                HStack {
                    
                    Text(title)
                        .font(.title2.weight(.semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    
                    if let explicit = songOfTheDay.explicit {
                        if explicit {
                            ExplicitTag()
                                .frame(width: 20)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            if let album = songOfTheDay.album {
                HStack {
                    Text(album)
                        .font(.title3)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
           
            
            Spacer()
            
            HStack {
                Spacer()
                
                if let spotifyLink = songOfTheDay.spotifyLink {
                    if let url = URL(string: spotifyLink) {
                        Link(destination: url) {
                            SpotifyIcon()
                                .frame(width: iconDimension, height: iconDimension)
                        }
                    }
                }
                
                if let appleMusicLink = songOfTheDay.appleMusicLink {
                    if let url = URL(string: appleMusicLink) {
                        Link(destination: url) {
                            AppleMusicIcon()
                                .frame(width: iconDimension, height: iconDimension)
                        }
                    }
                }
                
            }
        }
        .padding()
        .sheet(isPresented: $showDetails) {
            VStack {
                if let title = songOfTheDay.title, let artist = songOfTheDay.artist {
                    Text("\(title) by \(artist)")
                        .font(.title.weight(.semibold))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal)
                        .padding(.top)
                }
                 
                if let releaseYear = songOfTheDay.releaseYear, let genre = songOfTheDay.genre {
                    Text("\(releaseYear) - \(genre.capitalized)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .foregroundStyle(Color(.systemPink))
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
                ScrollView(.vertical) {
                    if let details = songOfTheDay.details {
                        Text(details)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }
                
            }
        }
    }
}

#Preview {
    DisplaySongCell(songOfTheDay: SongOfTheDay.song)
}
