//
//  HistoryPuzzleCell.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 7/5/24.
//

import SwiftUI

struct HistoryPuzzleCell: View {
    let puzzle: PuzzleModel
    
    @State private var albums: [AlbumModel]?
    @State private var failed: Bool = false
    
    let cellHeight: CGFloat = UIScreen.main.bounds.width / 4
    
    var body: some View {
        HStack {
            if let albums = albums {
                Spacer()
                
                ForEach(albums, id: \.id) { album in
                    Menu {
                        Text("Album: \(album.title)")
                        
                        Text("Artist: \(album.artist)")
                        
                        Link("Open with Apple Music", destination: URL(string: album.appleMusicLink)!)
                        
                        Link("Open with Spotify", destination: URL(string: album.spotifyLink)!)
                    } label: {
                        HistoryAlbumCell(album: album)
                    }
                    
                    Spacer()
                }
                
                
                
            } else if failed {
                Button {
                    self.onAppearActions()
                } label: {
                    TapToReloadLabel()
                }
            } else {
                ProgressView()
                    .progressViewStyle(.linear)
            }
        }
        .frame(maxHeight: cellHeight)
        .onAppear {
            self.onAppearActions()
        }
    }
    
    private func onAppearActions() {
        failed = false
        Task {
            do {
                albums = try await FetchService.fetchAlbumsByPuzzle(puzzle: puzzle)
            } catch {
                failed = true
            }
        }
    }
}



//#Preview {
//    HistoryPuzzleCell()
//}
