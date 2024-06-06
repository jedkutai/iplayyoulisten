//
//  HistoryView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI

struct HistoryView: View {
    @State private var songsOfTheDay: [SongOfTheDay] = []
    @State private var searchText: String = ""
    
    @State private var failed = false
    @State private var loading = true
    
    var filteredSongs: [SongOfTheDay] {
        if searchText.isEmpty {
            return songsOfTheDay
        } else {
            return songsOfTheDay.filter { $0.album?.localizedCaseInsensitiveContains(searchText) ?? false || $0.title?.localizedCaseInsensitiveContains(searchText) ?? false || $0.artist?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredSongs, id: \.id) { song in
                        NavigationLink {
                            DisplaySongCell(songOfTheDay: song)
                        } label: {
                            HistoryCell(songOfTheDay: song)
                        }
                        .contextMenu {
                            if let spotifyLink = song.spotifyLink {
                                if let url = URL(string: spotifyLink) {
                                    Link(destination: url, label: {
                                        Text("Spotify")
                                    })
                                }
                            }
                            
                            if let appleMusicLink = song.appleMusicLink {
                                if let url = URL(string: appleMusicLink) {
                                    Link(destination: url, label: {
                                        Text("Apple Music")
                                    })
                                }
                            }
                        }
                    }
//                    .listRowSeparator(.hidden)
                }
                .searchable(text: $searchText, prompt: "Find Songs")
                .autocorrectionDisabled(true)
                .listStyle(.plain)
            }
            .navigationTitle("Last 30 Songs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
    
                if failed {
                    Button {
                        self.onAppearActions()
                    } label: {
                        Image(systemName: "arrow.circlepath")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                    }
                } else if loading {
                    ProgressView()
                }
            }
            .onAppear {
                self.onAppearActions()
            }
        }
    }
    
    private func onAppearActions() {
        failed = false
        loading = true
        Task {
            do {
                self.songsOfTheDay = try await FetchService.fetchLast30SongsOfTheDay()
            } catch {
                failed = true
            }
            loading = false
        }
    }
}

#Preview {
    HistoryView()
}
