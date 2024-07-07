//
//  HistoryView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 7/5/24.
//

import SwiftUI

struct HistoryView: View {
    @State private var puzzles: [PuzzleModel]?
    @State private var failed: Bool = false
    
    let spotifyPlaylistLink: String = "https://open.spotify.com/playlist/6vlcf6LYq07s9hdwqBHjcU?si=3d159c562d794ec3"
    let appleMusicPlaylistLink: String = "https://music.apple.com/us/playlist/put-on-music-trivia/pl.u-leylGJJT9R3l2Y"
    
    let limit: Int = 7
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                
                VStack {
                    
                    if let puzzles = puzzles {
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            ForEach(puzzles, id: \.id) { puzzle in
                                HStack {
                                    Text("\(puzzle.startTime.dateValue().formatted(date: .long, time: .omitted))")
                                        .foregroundStyle(.black)
                                        .font(.title.weight(.bold))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                HistoryPuzzleCell(puzzle: puzzle)
                            }
                        }
                    } else if failed {
                        Button {
                            self.onAppearActions()
                        } label: {
                            TapToReloadLabel()
                        }
                    } else {
                        ProgressView("Loading")
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.onAppearActions()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Link(destination: URL(string: appleMusicPlaylistLink)!, label: {
                        AppleMusicIcon()
                            .frame(width: 25, height: 25)
                        
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Link(destination: URL(string: spotifyPlaylistLink)!, label: {
                        SpotifyIcon()
                            .frame(width: 25, height: 25)
                        
                    })
                }
            }
        }
    }
    
    private func onAppearActions() {
        failed = false
        Task {
            do {
                puzzles = try await FetchService.fetchPuzzlesHistory(limit: self.limit)
            } catch {
                failed = true
                print("History: \(error.localizedDescription)")
            }
        }
        
    }
}

//#Preview {
//    HistoryView()
//}
