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
    
    @State private var showDetails = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            if let artist = songOfTheDay.artist{
                Text(artist)
                    .font(.title.weight(.bold))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .minimumScaleFactor(0.1)
            }
            
            Button {
                if let details = songOfTheDay.details {
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            Text(title)
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                            
                            if let explicit = songOfTheDay.explicit {
                                if explicit {
                                    ExplicitTag()
                                }
                            }
                        }
                    }
                    .frame(height: 25)
                }
                .padding(.horizontal)
            }
            
            if let album = songOfTheDay.album {
                HStack {
                    Text(album)
                        .font(.title3)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    
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
                        }
                    }
                }
                
                if let appleMusicLink = songOfTheDay.appleMusicLink {
                    if let url = URL(string: appleMusicLink) {
                        Link(destination: url) {
                            AppleMusicIcon()
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
                        .minimumScaleFactor(0.1)
                        .padding()
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
