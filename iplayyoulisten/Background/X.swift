//
//  X.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI
import Combine
import CoreLocation

@MainActor
class X: ObservableObject {
    
    @Published var lastPuzzlePlayedId: String = UserDefaults.standard.string(forKey: "lastPuzzlePlayedId") ?? ""
    @Published var hintsRemaining: Int = UserDefaults.standard.integer(forKey: "hintsRemaining")
    
    @Published var oneOrMoreCorrect: Int = UserDefaults.standard.integer(forKey: "oneOrMoreCorrect")
    @Published var twoOrMoreCorrect: Int = UserDefaults.standard.integer(forKey: "twoOrMoreCorrect")
    @Published var threeOrMoreCorrect: Int = UserDefaults.standard.integer(forKey: "threeOrMoreCorrect")
    @Published var fourOrMoreCorrect: Int = UserDefaults.standard.integer(forKey: "fourOrMoreCorrect")
    
    @Published var stopAutomaticallyPlayingMusic: Bool = UserDefaults.standard.bool(forKey: "stopAutomaticallyPlayingMusic")
    
    @Published var showMusicPlayer: Bool = true
    
    @Published var selectedBadge: String = UserDefaults.standard.string(forKey: "selectedBadge") ?? "twoOrMoreCorrect"
    
    private var oneOrMoreCorrectHolder: Int = 0
    private var twoOrMoreCorrectHolder: Int = 0
    private var threeOrMoreCorrectHolder: Int = 0
    private var fourOrMoreCorrectHolder: Int = 0
    
    func updateLastPuzzleId(id: String) {
        UserDefaults.standard.set(id, forKey: "lastPuzzlePlayedId")
        lastPuzzlePlayedId = id
    }
    
    func automaticallyPlayMusicToggle() {
        self.stopAutomaticallyPlayingMusic.toggle()
        UserDefaults.standard.set(self.stopAutomaticallyPlayingMusic, forKey: "stopAutomaticallyPlayingMusic")
    }
    
    func updateHintsRemaining(change: Int) {
        hintsRemaining += change
        if hintsRemaining < 0 {
            hintsRemaining = 0
        } else if hintsRemaining > 25 {
            hintsRemaining = 25
        }
        
        UserDefaults.standard.set(hintsRemaining, forKey: "hintsRemaining")
    }
    
    func cacheStreaks() {
        // move streaks to placeholder
        self.oneOrMoreCorrectHolder = self.oneOrMoreCorrect
        self.twoOrMoreCorrectHolder = self.twoOrMoreCorrect
        self.threeOrMoreCorrectHolder = self.threeOrMoreCorrect
        self.fourOrMoreCorrectHolder = self.fourOrMoreCorrect
        
        // clear user streaks
        self.oneOrMoreCorrect = 0
        self.twoOrMoreCorrect = 0
        self.threeOrMoreCorrect = 0
        self.fourOrMoreCorrect = 0
        UserDefaults.standard.set(0, forKey: "oneOrMoreCorrect")
        UserDefaults.standard.set(0, forKey: "twoOrMoreCorrect")
        UserDefaults.standard.set(0, forKey: "threeOrMoreCorrect")
        UserDefaults.standard.set(0, forKey: "fourOrMoreCorrect")
    }
    
    func updateStreaks(scoreBoard: [String: Bool]) {
        // get user score from dictionary
        var amountCorrect: Int = 0
        for gotItRight in scoreBoard.values {
            if gotItRight {
                amountCorrect += 1
            }
        }
        
        // return user streaks from placeholder
        self.oneOrMoreCorrect = self.oneOrMoreCorrectHolder
        self.twoOrMoreCorrect = self.twoOrMoreCorrectHolder
        self.threeOrMoreCorrect = self.threeOrMoreCorrectHolder
        self.fourOrMoreCorrect = self.fourOrMoreCorrectHolder
        
        // clear placeholder
        self.oneOrMoreCorrectHolder = 0
        self.twoOrMoreCorrectHolder = 0
        self.threeOrMoreCorrectHolder = 0
        self.fourOrMoreCorrectHolder = 0
        
        // update user streaks based on score
        if amountCorrect == 0 {
            
            self.oneOrMoreCorrect = 0
            self.twoOrMoreCorrect = 0
            self.threeOrMoreCorrect = 0
            self.fourOrMoreCorrect = 0
            
        } else if amountCorrect == 1 {
            
            self.oneOrMoreCorrect += 1
            self.twoOrMoreCorrect = 0
            self.threeOrMoreCorrect = 0
            self.fourOrMoreCorrect = 0
            
        } else if amountCorrect == 2 {
            
            self.oneOrMoreCorrect += 1
            self.twoOrMoreCorrect += 1
            self.threeOrMoreCorrect = 0
            self.fourOrMoreCorrect = 0
            
        } else if amountCorrect == 3 {
            
            self.oneOrMoreCorrect += 1
            self.twoOrMoreCorrect += 1
            self.threeOrMoreCorrect += 1
            self.fourOrMoreCorrect = 0
            
        } else if amountCorrect == 4 {
            
            self.oneOrMoreCorrect += 1
            self.twoOrMoreCorrect += 1
            self.threeOrMoreCorrect += 1
            self.fourOrMoreCorrect += 1
            
        }
        
        UserDefaults.standard.set(self.oneOrMoreCorrect, forKey: "oneOrMoreCorrect")
        UserDefaults.standard.set(self.twoOrMoreCorrect, forKey: "twoOrMoreCorrect")
        UserDefaults.standard.set(self.threeOrMoreCorrect, forKey: "threeOrMoreCorrect")
        UserDefaults.standard.set(self.fourOrMoreCorrect, forKey: "fourOrMoreCorrect")
    }
    
}
