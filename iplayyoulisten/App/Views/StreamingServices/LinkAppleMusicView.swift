//
//  LinkAppleMusicView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 7/1/24.
//

import SwiftUI
import MusicKit

struct LinkAppleMusicView: View {
    @State private var status = MusicAuthorization.currentStatus
    
    var body: some View {
        ZStack {
            AppBackground()
            
            if status == .authorized {
                accountLinked
            } else {
                linkAccount
            }
        }
    }
    
    var linkAccount: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    HStack {
                        Text("Link your account to hear music hints.")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                            .foregroundStyle(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ExplainedBlock(
                        iconName: "1.square",
                        header: "Get Apple Music",
                        explanations: ["You can skip this step if you already have Apple Music."]
                    )
                    .padding(.horizontal)
                    
                    HStack {
                        Link("Get Apple Music", destination: URL(string: "https://music.apple.com/us/browse")!)
                        
                        Image(systemName: "link")
                    }
                    .foregroundStyle(.pink)
                    .padding(.top)
                    
                    ExplainedBlock(
                        iconName: "2.square",
                        header: "Allow Access",
                        explanations: ["Allow access for musical hints."]
                    )
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Button {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            if UIApplication.shared.canOpenURL(settingsURL) {
                                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                            }
                        }
                    } label: {
                        Text("Allow Access")
                            .foregroundStyle(Color(.systemBlue))
                    }
                    .padding(.top)
                    
                    
                }
                
                
            }
            .navigationTitle("Link Apple Music")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                Task {
                    status = await MusicAuthorization.request()
                }
            }
        }
    }
    
    var accountLinked: some View {
        Text("Your Account has been linked.")
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}


private struct ExplainedBlock: View {
    let iconName: String
    let header: String
    let explanations: [String]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text(header)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                
                Spacer()
            }
            
            if !explanations.isEmpty {
                ForEach(explanations, id: \.self) { explanation in
                    HStack {
                        Text("- \(explanation)")
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.leading)
                }
            }
        }
        .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
}

//#Preview {
//    LinkAppleMusicView()
//}
