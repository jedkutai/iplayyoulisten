//
//  ShowAnswer.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/21/24.
//

import SwiftUI

struct ShowAnswer: View {
    let artistName: String
    let guessState: GuessState
    
    let maxHeight: CGFloat = UIScreen.main.bounds.height * 0.7
    
    var body: some View {
        if guessState == .correct {
            correct
        } else if guessState == .incorrect {
            incorrect
        }
    }
    
    var correct: some View {
        DisplayArtist(artistName: artistName)
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .background(
                ZStack {
                    Color(.systemGreen)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.thickMaterial)
                }
                    
            )
            
    }
    
    var incorrect: some View {
        DisplayArtist(artistName: artistName)
    }
    
}



#Preview {
    ShowAnswer(artistName: "Lil Wayne", guessState: .correct)
}
