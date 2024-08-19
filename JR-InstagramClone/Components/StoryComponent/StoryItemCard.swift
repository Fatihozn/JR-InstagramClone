//
//  StoryItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI
import Kingfisher

struct StoryItemCard: View {
    
    @State private var goToStoryPage = false
    @EnvironmentObject var globalClass: GlobalClass
    
    @State var user: User?
    
    let size: CGFloat
    var isOnStory = false
    var isShowStory = false
    var isShowUserName = false
    
    @State var isHaveStory = false
    
    @Binding var isProfilePageActive: Bool
    
    var body: some View {
        
        Group {
            if (user?.stories?
                .filter { $0.timestamp.hourDiffrence() != "eski" }
                .compactMap { $0.seenBy?.contains(globalClass.User?.id ?? "") ?? false ? true : nil } == []
                || isShowStory) && !isOnStory && isHaveStory {
                Button {
                    withAnimation {
                        goToStoryPage.toggle()
                    }
                } label: {
                    VStack {
                        storyImage()
                            .overlay(
                                Circle().stroke(
                                    LinearGradient(
                                        gradient:
                                            user?.stories?
                                            .filter { $0.timestamp.hourDiffrence() != "eski" }
                                            .compactMap { $0.seenBy?.contains(globalClass.User?.id ?? "") ?? false ? true : nil } == [] ?
                                        Gradient(colors: [Color(hex: "#405DE6"),
                                                          Color(hex: "#833AB4"),
                                                          Color(hex: "#C13584"),
                                                          Color(hex: "#F77737"),
                                                          Color(hex: "#FCAF45")]) :
                                            Gradient(colors: [Color.gray]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading
                                    ),
                                    lineWidth: 4
                                )
                            )
                        
                        if isShowUserName {
                            if let userName = user?.username {
                                Text(userName)
                            } else {
                                Text("Kullanıcı adı")
                            }
                        }
                        
                    }
                }
                
            } else {
                NavigationLink {
                    ProfilePage(user: user, isProfilePageActive: $isProfilePageActive)
                } label: {
                    
                    VStack {
                        storyImage()
                            .overlay(
                                (!isHaveStory || isOnStory) ? AnyView(EmptyView()) : AnyView(Circle().stroke(
                                    LinearGradient(
                                        gradient:
                                            user?.stories?
                                            .filter { $0.timestamp.hourDiffrence() != "eski" }
                                            .compactMap { $0.seenBy?.contains(globalClass.User?.id ?? "") ?? false ? true : nil } == [] ?
                                        Gradient(colors: [Color(hex: "#405DE6"),
                                                          Color(hex: "#833AB4"),
                                                          Color(hex: "#C13584"),
                                                          Color(hex: "#F77737"),
                                                          Color(hex: "#FCAF45")]) : 
                                            Gradient(colors: [Color.gray]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading
                                    ),
                                    lineWidth: 4
                                ))
                            )
                        
                        if isShowUserName {
                            if let userName = user?.username {
                                Text(userName)
                            } else {
                                Text("Kullanıcı adı")
                            }
                        }
                        
                    }
                }
                
            }
        }
        .onAppear {
            isHaveStory = !(user?.stories?.filter { $0.timestamp.hourDiffrence() != "eski" }.isEmpty ?? true)
            
        }
        .fullScreenCover(isPresented: $goToStoryPage, content: {
            StoryPage(user: user)
            
        })
    }
    
    private func storyImage() -> some View {
        return VStack {
            if let photo = user?.profilePhoto?.photoUrl {
                KFImage(URL(string: photo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            }
        }
    }
}



