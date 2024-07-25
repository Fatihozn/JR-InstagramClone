//
//  StoryItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI

struct StoryItemCard: View {
    
    @State private var showStory = false
    
    let size: CGFloat
    var userName = ""
    var isOnStory = false
    
    @State var isSeenStory = false
    
    var body: some View {
        
        Group {
            if (!isSeenStory || userName != "") && !isOnStory {
                Button {
                    withAnimation {
                        isSeenStory.toggle()
                        showStory.toggle()
                        
                    }
                } label: {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(
                                    LinearGradient(
                                        gradient: !isSeenStory ? Gradient(colors: [Color.purple, Color.pink, Color.red, Color.orange, Color.yellow]) : Gradient(colors: [Color.gray]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading
                                    ),
                                    lineWidth: 4
                                )
                            )
                        
                        if userName != "" {
                            Text("Kullanıcı adı")
                        }
                        
                    }
                }
                
            } else {
                NavigationLink {
                    ProfilePage()
                } label: {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                            .overlay(
                                isOnStory ? AnyView(EmptyView()) : AnyView(Circle().stroke(
                                        LinearGradient(
                                            gradient: !isSeenStory ? Gradient(colors: [Color.purple, Color.pink, Color.red, Color.orange, Color.yellow]) : Gradient(colors: [Color.gray]),
                                            startPoint: .topTrailing,
                                            endPoint: .bottomLeading
                                        ),
                                        lineWidth: 4
                                    ))
                            )
                        
                        if userName != "" {
                            Text("Kullanıcı adı")
                        }
                        
                    }
                }
                
            }
        }
        .fullScreenCover(isPresented: $showStory, content: {
            StoryPage()
        })
    }
}


