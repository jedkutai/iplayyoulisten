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
    
    func updateLastPuzzleId(id: String) {
        UserDefaults.standard.set(id, forKey: "lastPuzzlePlayedId")
        lastPuzzlePlayedId = id
    }
}
