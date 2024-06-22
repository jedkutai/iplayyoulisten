//
//  MainMenuView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct MainMenuView: View {
    @State private var showHowToPlaySheet: Bool = false
    
    
    let iconDimension: CGFloat = UIScreen.main.bounds.width * 0.25
    var body: some View {
        NavigationStack {
            ZStack {
                MenuBackground()
                
                VStack {
                    Spacer()
                    
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconDimension, height: iconDimension)
                        .foregroundStyle(.thinMaterial)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink {
                            PreGameView()
                        } label: {
                            CustomLabel(title: "Play")
                        }
                        
//                        NavigationLink {
//                            
//                        } label: {
//                            CustomLabel(title: "Archives")
//                        }
                        
                        NavigationLink {
                            HowToPlayView()
                        } label: {
                            CustomLabel(title: "How To Play")
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

private struct CustomLabel: View {
    let title: String
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text(title)
            .font(.title.weight(.semibold))
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .shadow(radius: 5)
    }
}

#Preview {
    MainMenuView()
}
