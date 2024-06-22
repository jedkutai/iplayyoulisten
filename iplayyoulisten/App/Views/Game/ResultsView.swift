//
//  ResultsView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/20/24.
//

import SwiftUI

struct ResultsView: View {
    let puzzle: PuzzleModel
    let albums: [AlbumModel]
    let scoreCard: [String: Bool]
    
    var hideMenuButton: Any?
    
    let iconDimension: CGFloat = UIScreen.main.bounds.width * 0.25
    
    let appStoreLink: URL = URL(string: "google.com")!
    var body: some View {
        NavigationStack {
            ZStack {
                MenuBackground()
                
                VStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconDimension, height: iconDimension)
                        .foregroundStyle(.thinMaterial)
                    
                    
                    
                    ForEach(albums, id: \.id) { album in
                        if let correct = scoreCard[album.id] {
                            HStack {
                                if correct {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15)
                                        .foregroundStyle(Color(.systemGreen))
                                    
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15)
                                        .foregroundStyle(Color(.systemRed))
                                }
                                
                                ResultCell(album: album, correct: correct)
                            }
                            .padding(.top)
                            
                        }
                    }
                    Spacer()
                    
                    Text(puzzle.startTime.dateValue().formatted(date: .abbreviated, time: .omitted))
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                    
                    Spacer()
                    
                    Text("Music Trivia")
                        .font(.footnote)
                        .foregroundStyle(.black)
                }
                .padding()
            }
            .toolbar {
                
                if hideMenuButton == nil {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            MainMenuView(puzzle: puzzle, albums: albums, scoreCard: scoreCard).navigationBarBackButtonHidden()
                        } label: {
                            Text("Menu")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
    }
    
    private func generateScoreMessage() -> String {
        return "Bippity boppity"
    }
}


#Preview {
    ResultsView(puzzle: PuzzleModel.puzzle, albums: AlbumModel.albums, scoreCard: AlbumModel.scoreCard)
}
