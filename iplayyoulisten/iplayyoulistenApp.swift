//
//  iplayyoulistenApp.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/4/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct iplayyoulistenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var x = X()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(x)
        }
    }
}
