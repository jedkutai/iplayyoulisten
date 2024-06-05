//
//  AuthService.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct AuthService {
    static func anonymousLogin() async throws {
        try await Auth.auth().signInAnonymously()
    }
}
