//
//  PreGameView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct PreGameView: View {
    @State private var puzzle: PuzzleModel?
    @State private var failed: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                
                VStack {
                    if let puzzle = self.puzzle {
                        PreGameLoadedView(puzzle: puzzle)
                    } else if failed {
                        Button {
                            self.onAppearActions()
                        } label: {
                            TapToReloadLabel()
                        }
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            }
            .onAppear {
                self.onAppearActions()
            }
        }
    }
    
    
    private func onAppearActions() {
        self.failed = false
        Task {
            do {
                self.puzzle = try await FetchService.fetchTodaysPuzzle()
                if self.puzzle == nil {
                    failed = true
                }
            } catch {
                self.failed = true
            }
        }
    }
}

private struct PreGameLoadedView: View {
    let puzzle: PuzzleModel
    
    @EnvironmentObject var x: X
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if x.lastPuzzlePlayedId == puzzle.id { //
                    Spacer()
                    
                    Text("Next Puzzle:")
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                    
                    
                    Text(puzzle.endTime.dateValue().formatted(date: .abbreviated, time: .shortened))
                        .font(.title.weight(.semibold))
                        .foregroundStyle(Color(.systemGray))
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                    
                    Spacer()
                    
                    Text("You can't play a puzzle more than once.")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                    
                } else {
                    NavigationLink {
                        GameController(puzzle: puzzle).navigationBarBackButtonHidden()
                    } label: {
                        Text("Start")
                            .font(.title.weight(.semibold))
                            .foregroundStyle(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                    }
                    
                    Text("Once you start today's puzzle, you can't replay it.")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                    
                }
            }
        }
    }
}

//#Preview {
//    PreGameView()
//}
