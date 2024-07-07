//
//  MainMenuView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI
import MusicKit

struct MainMenuView: View {
    var puzzle: PuzzleModel?
    var albums: [AlbumModel]?
    var scoreCard: [String: Bool]?
    var hintsUsed: Int?

    
    @State private var showHowToPlaySheet: Bool = false
    @State private var status = MusicAuthorization.currentStatus
    
    let iconDimension: CGFloat = UIScreen.main.bounds.width * 0.25
    @EnvironmentObject var x: X
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                
                VStack {
                    Spacer()
                    
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconDimension, height: iconDimension)
                        .foregroundStyle(.thinMaterial)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink {
                            PreGameView()
                        } label: {
                            CustomLabel(title: "Play")
                        }
                        

                        
                        if let puzzle = self.puzzle, let albums = self.albums, let scoreCard = self.scoreCard, let hintsUsed = hintsUsed {
                            NavigationLink {
                                ResultsView(puzzle: puzzle, albums: albums, scoreCard: scoreCard, hintsUsed: hintsUsed, hideMenuButton: true)
                            } label: {
                                CustomLabel(title: "Previous Game")
                            }
                        }
                        
                        NavigationLink {
                            HistoryView()
                        } label: {
                            CustomLabel(title: "History")
                        }
                        
                        
                        NavigationLink {
                            HowToPlayView()
                        } label: {
                            CustomLabel(title: "How to Play")
                        }
                        
                        if status != .authorized {
                            NavigationLink {
                                LinkAppleMusicView()
                            } label: {
                                CustomLabel(title: "Link Apple Music")
                            }
                        }

                    }
                    
                    Spacer()
                    

                    
                    if status == .authorized {
                        Text("Apple Music Linked")
                            .font(.footnote)
                            .foregroundStyle(Color(.systemGray))
                    }
                }
                .padding()
            }
            .toolbar {
                
                if x.twoOrMoreCorrect > 0 {
                    ToolbarItem(placement: .topBarTrailing) {
                        StreaksDisplay()
                    }
                }
            }
            .onAppear {
                withAnimation {
                    x.showMusicPlayer = true
                }
            }
            .onDisappear {
                withAnimation {
                    x.showMusicPlayer = false
                }
            }
            
        }
    }
    
    
}



private struct CustomLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title.weight(.semibold))
            .foregroundStyle(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
}

//#Preview {
//    MainMenuView()
//}
