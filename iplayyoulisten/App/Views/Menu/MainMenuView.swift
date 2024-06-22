//
//  MainMenuView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct MainMenuView: View {
    var puzzle: PuzzleModel?
    var albums: [AlbumModel]?
    var scoreCard: [String: Bool]?
    
    @State private var showHowToPlaySheet: Bool = false
    
    let iconDimension: CGFloat = UIScreen.main.bounds.width * 0.25
    var body: some View {
        NavigationStack {
            ZStack {
                MenuBackground()
                
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
                        

                        
                        if let puzzle = self.puzzle, let albums = self.albums, let scoreCard = self.scoreCard {
                            NavigationLink {
                                ResultsView(puzzle: puzzle, albums: albums, scoreCard: scoreCard, hideMenuButton: true)
                            } label: {
                                CustomLabel(title: "Previous Game")
                            }
                        }
                        
                        NavigationLink {
                            HowToPlayView()
                        } label: {
                            CustomLabel(title: "How To Play")
                        }
                        

                    }
                    
                    Spacer()
                    
                    Text("Music Trivia")
                        .font(.footnote)
                        .foregroundStyle(.black)
                }
                .padding()
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
    }
}

#Preview {
    MainMenuView()
}
