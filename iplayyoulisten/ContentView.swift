//
//  ContentView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var x: X
    var body: some View {
        ZStack {
            AppBackground()
            
            MainMenuView()
            
//            VStack {
//                Spacer()
//                
//                MusicPill()
//                
//            }
//            .padding()
                
        }
        .tint(.black)
        .preferredColorScheme(.light)
    }
}

//#Preview {
//    ContentView()
//}
