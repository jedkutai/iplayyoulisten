//
//  CustomKeyboard.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/24/24.
//

import SwiftUI

struct CustomKeyboard: View {
    @Binding var letters: [String]
    
    let hiddenIndexes: [Int]

    
    let keyboardHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    let letterSpacing: CGFloat = UIScreen.main.bounds.width / 110
    
    let topLetters: [String] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let middleLetters: [String] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    let bottomLetters: [String] = ["Z", "X", "C", "V", "B", "N", "M"]
    
    var body: some View {
        VStack {
            HStack(spacing: letterSpacing) {
//                Spacer()
                ForEach(topLetters, id: \.self) { letter in
                    Button {
                        addLetter(letter: letter)
                    } label: {
                        KeyboardKey(key: letter, keyboardHeight: keyboardHeight)
                    }
                }
//                Spacer()
            }
            
            HStack(spacing: letterSpacing) {
//                Spacer()
                ForEach(middleLetters, id: \.self) { letter in
                    Button {
                        addLetter(letter: letter)
                    } label: {
                        KeyboardKey(key: letter, keyboardHeight: keyboardHeight)
                    }
                }
//                Spacer()
            }
            
            HStack(spacing: letterSpacing) {
//                Spacer()
                
                Button {
                    clearAll()
                } label: {
                    KeyboardKeySpecial(systemImageName: "trash", keyboardHeight: keyboardHeight)
                }
                
                Spacer()
                ForEach(bottomLetters, id: \.self) { letter in
                    Button {
                        addLetter(letter: letter)
                    } label: {
                        KeyboardKey(key: letter, keyboardHeight: keyboardHeight)
                    }
                }
                Spacer()
                
                Button {
                    backSpace()
                } label: {
                    KeyboardKeySpecial(systemImageName: "delete.backward", keyboardHeight: keyboardHeight)
                }
                
//                Spacer()
            }
        }
        .frame(height: keyboardHeight)
    }
    
    private func addLetter(letter: String) {
        let letterLimit = hiddenIndexes.count
        if letters.count < letterLimit {
            letters.append(letter)
        }
    }
    
    private func backSpace() {
        if !letters.isEmpty  {
            letters.removeLast()
        }
    }
    
    private func clearAll() {
        letters.removeAll()
    }
}

struct KeyboardKey: View {
    let key: String
    let keyboardHeight: CGFloat
    
    let keyWidth: CGFloat = UIScreen.main.bounds.width / 12
    var body: some View {
        Text(key)
            .font(.title2)
            .foregroundStyle(.black)
            .frame(width: keyWidth, height: keyboardHeight / 4)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.ultraThickMaterial)
            )
    }
}

struct KeyboardKeySpecial: View {
    let systemImageName: String
    let keyboardHeight: CGFloat
    
    let keyWidth: CGFloat = UIScreen.main.bounds.width / 12
    var body: some View {
        Image(systemName: systemImageName)
            .foregroundStyle(.black)
            .frame(width: keyWidth, height: keyboardHeight / 4)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.ultraThickMaterial)
            )
    }
}

//#Preview {
//    CustomKeyboard(letters: [])
//}
