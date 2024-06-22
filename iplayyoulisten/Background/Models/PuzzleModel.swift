//
//  PuzzleModel.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import Foundation
import Firebase

struct PuzzleModel: Codable, Hashable, Identifiable {
    let id: String
    let startTime: Timestamp
    let endTime: Timestamp
    let albumIds: [String]
    
}

extension PuzzleModel {
    static var puzzle: PuzzleModel = .init(id: "hSDs3JoiNgu0A99X07gZ", startTime: Timestamp(date: Date.now), endTime: Timestamp(date: Date.now), albumIds: ["sebffs2UE1pDwUc1OJCH", "WPD8D1FZNTvwiHUyp3CI", "10j9KnGD9rPCZMJDGp9Z", "C1F9xKj8mBPVC9bNFr4t"])
}
