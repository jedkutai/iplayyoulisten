//
//  ContentView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainMenuView()
            .tint(.black)
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
