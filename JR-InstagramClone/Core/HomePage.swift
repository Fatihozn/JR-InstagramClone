//
//  HomeView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct HomePage: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State var posts: [Post] = []
    @Binding var user: User?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                ZStack {
                    ScrollView(showsIndicators: false) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible(minimum: width / 4, maximum: .infinity))]) {
                                ForEach(0...5, id: \.self) { i in
                                    
                                    if i == 0 {
                                        MyStoryItemCard(size: width / 4, text: "Hikayen")
                                            .padding(3)
                                    } else {
                                        StoryItemCard(size: width / 4, isShowStory: true, isShowUserName: true, isProfilePageActive: .constant(false))
                                            .padding(3)
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                        if posts.count != 0 {
                            ForEach(posts, id: \.id) { post in
                                
                                PostItemCard(post: post, width: width)
                                
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
                    NavigationLink {
                        //FriendsPage()
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
        }
        
    }
}



//#Preview {
//    HomeView()
//}
