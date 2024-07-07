//
//  MusicHintPlayer.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 7/1/24.
//

import SwiftUI
import MusicKit
//import AVKit

struct MusicHintPlayer: View {
    let previewId: String
    
    @State private var musicPlayer = ApplicationMusicPlayer.shared
    @State private var status = MusicAuthorization.currentStatus
    @State private var musicPlaying = false
    @State private var song: Song?
    
    
    var body: some View {
        if status == .authorized {
            Group {
                if musicPlaying {
                    AppleMusicIcon()
                        .frame(width: 30, height: 30)
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                getSong()
            }
            .onDisappear {
                self.pauseSong()
            }
            
        } else {
            NavigationLink {
                LinkAppleMusicView()
            } label: {
                AppleMusicIcon()
                    .frame(width: 30, height: 30)
            }
        }
            
    }
    
    private func getSong() {
        Task {
            do {
                let request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID(previewId))
                let response = try await request.response()
                
                self.song = response.items.first
                if let song = self.song {
                    
                    playSong(song: song)
                }
                
            } catch {
                print("MusicHintPlayer Error: \(error.localizedDescription)")
            }
        }
    }
    
    func playSong(song: Song) {
        Task {
            do {
                musicPlayer.queue = [song]
                try await musicPlayer.play()
                withAnimation {
                    musicPlaying = true
                }
                
            } catch {
                print("Failed to play song: \(error)")
            }
        }
    }
    
    func pauseSong() {
        self.musicPlayer.stop()
        musicPlaying = false
    }
    
    
}

//#Preview {
//    MusicHintPlayer()
//}
