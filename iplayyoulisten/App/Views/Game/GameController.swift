//
//  GameController.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI

struct GameController: View {
    let puzzle: PuzzleModel
    @State var dontSaveId: Any?
    @State private var albums: [AlbumModel]?
    @State private var failed: Bool = false
    
    @EnvironmentObject var x: X
    
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        if let albums = self.albums {
            GameView(puzzle: puzzle, albums: albums)
        } else if failed {
            NavigationStack {
                ZStack {
                    MenuBackground()
                    
                    Button {
                        self.onAppearActions()
                    } label: {
                        TapToReloadLabel()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Exit")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        } else {
            NavigationStack {
                ZStack {
                    MenuBackground()
                    
                    ProgressView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Exit")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .onAppear {
                onAppearActions()
            }
        }
    }
    
    private func onAppearActions() {
        self.failed = false
        Task {
            do {
                self.albums = try await FetchService.fetchAlbumsByPuzzle(puzzle: puzzle)
                if dontSaveId == nil {
                    x.updateLastPuzzleId(id: puzzle.id)
                }
            } catch {
                failed = true
            }
        }
    }
}

//#Preview {
//    GameController()
//}
