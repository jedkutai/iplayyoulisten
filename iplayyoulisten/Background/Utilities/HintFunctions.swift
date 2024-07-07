//
//  HintFunctions.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/23/24.
//

import Foundation

struct HintFunctions {
    
    
    static func hintDisplayText(artistName: String, hiddenIndexes: [Int], guessedLetters: [String]) ->  String {
        var hint: String = ""
        var count: Int = 0
        let limit: Int = guessedLetters.count
        var empty: Bool = true
        
        
        for (dex, char) in artistName.uppercased().enumerated() {
            if !empty {
                hint += " "
            }
            
            if hiddenIndexes.contains(dex) {
                if count < limit {
                    hint += guessedLetters[count].uppercased()
                    count += 1
                } else {
                    hint += "_"
                }
                
            } else {
                hint += String(char)
            }
            
            if empty {
                empty = false
            }
        }
        
        return hint
    }
    
    static func getHiddenIndexes(artistName: String) -> [Int] {
        let alphabet: String = "abcdefghijklmnopqrstuvwxyz"
        
        var indexes: [Int] = []
        
        for (dex, char) in artistName.lowercased().enumerated() {
            if alphabet.contains(char) {
                indexes.append(dex)
            }
        }
        
        return indexes //.shuffled()
    }
}
