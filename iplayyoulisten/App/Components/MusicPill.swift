//
//  MusicPill.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/25/24.
//

import SwiftUI
import AVFoundation

struct MusicPill: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var musicPlaying: Bool = false
    @State private var showOptionsSheet: Bool = false
    @State private var showOptions: Bool = false
    
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var x: X
    var body: some View {
        VStack {
            if x.showMusicPlayer {
                if showOptions {
                    Button {
                        withAnimation {
                            x.automaticallyPlayMusicToggle()
                        }
                    } label: {
                        HStack {
                            Image(systemName: x.stopAutomaticallyPlayingMusic ? "checkmark.square.fill" : "square")
                            
                            Text("Stop Music Auto Play")
                            
                        }
                        .foregroundStyle(.black)
                    }
                }
                Button {
                    withAnimation {
                        showOptions.toggle()
                    }
                } label: {
                    pill
                }
            } else {
                
            }
        }
        .onAppear {
            self.setupAudioPlayer()
            if !x.stopAutomaticallyPlayingMusic {
                playBackgroundMusic()
            }
        }
    }
    
    var pill: some View {
        HStack {

            VStack(alignment: .leading) {
                Text("Paradise")
                    .font(.subheadline.weight(.bold))
                
                Text("Jake Lambert")
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button {
                if musicPlaying {
                    pauseBackgroundMusic()
                } else {
                    playBackgroundMusic()
                }
            } label: {
                Image(systemName: musicPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                
            }
        }
        .foregroundStyle(.black)
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
        )
        .containerShape(Rectangle())
    }
    
    private func setupAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "paradise", ofType: "mp3") else {
            print("MP3 file not found")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
        } catch {
            print("Error loading audio player: \(error.localizedDescription)")
        }
    }
    
    private func playBackgroundMusic() {
        withAnimation {
            musicPlaying = true
        }
        audioPlayer?.play()
        
    }
    
    private func pauseBackgroundMusic() {
        withAnimation {
            musicPlaying = false
        }
        audioPlayer?.stop()
        
    }
    
    private func stopBackgroundMusic() {
        withAnimation {
            musicPlaying = false
        }
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        
    }
}


//#Preview {
//    MusicPill()
//}
