//
//  HomeView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var globalClass: GlobalClass
    @ObservedObject var viewModel = HomeViewModel()
    
    @State private var posts: [Post] = []
    @Binding var user: User?
    @State var goToChatList = false
    
    @State var storyList: [User?] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                ZStack {
                    ScrollView(showsIndicators: false) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible(minimum: width / 4, maximum: .infinity))]) {
                                
                                MyStoryItemCard(size: width / 4, text: "Hikayen")
                                    .padding(3)
                                
                                if storyList != [] {
                                    ForEach(storyList, id: \.self) { user in
                                        StoryItemCard(user: user, size: width / 4, isShowStory: true, isShowUserName: true, isProfilePageActive: .constant(false))
                                            .padding(3)
                                        
                                    }
                                }
                                
                            }
                        }
                        
                        if posts.count != 0 {
                            ForEach($posts, id: \.id) { $post in
                                PostItemCard(post: $post, width: width)
                            }
                        } else {
                            ProgressView()
                                .frame(width: width, height: height)
                        }
                        
                        
                    }
                    
                }
                
            }
            .onChange(of: user) {
                if let user {
                    viewModel.downloadAllPost(user.postIDs ?? []) { posts in
                        self.posts = posts
                    }
                    
                    viewModel.getFollowingList(followings: user.following) { followingList in
                        storyList = followingList.compactMap {
                            $0.stories?.compactMap { $0.timestamp.hourDiffrence() != "eski" } != [] ? $0 : nil }
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            
                        } label: {
                            Label("Takip Ettiklerin", systemImage: "person.2")
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Favoriler", systemImage: "star")
                        }
                        
                    } label: {
                        HStack {
                            Text("Senin için")
                                .font(.title2)
                            Image(systemName: "chevron.down")
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24) // İstediğiniz boyutlara ayarlayın
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Button {
                        goToChatList = true
                    } label: {
                        Image("chat")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24) // İstediğiniz boyutlara ayarlayın
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                BadgeView(count: 5)
                                    .offset(x: 10, y: -10)
                            )
                    }
                    
                }
            })
            .fullScreenCover(isPresented: $goToChatList, content: {
                ChatListPage()
            })
        }
        
    }
}



//#Preview {
//    HomeView()
//}
