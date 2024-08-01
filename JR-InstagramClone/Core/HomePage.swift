//
//  HomeView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct HomePage: View {
    
    @State var showStory = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                ZStack {
                    ScrollView(showsIndicators: false) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible(minimum: width / 4, maximum: .infinity))]) {
                                ForEach(0...5, id: \.self) { i in
                                    
                                    if i == 0 {
                                        MyStoryItemCard(size: width / 4, text: "Hikayen")
                                            .padding(3)
                                    } else {
                                        StoryItemCard(size: width / 4, userName: "a", isShowStory: true, isProfilePageActive: .constant(false))
                                            .padding(3)
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                        ForEach(0...5, id: \.self) { _ in
                            
                            PostItemCard(width: width)
                            
                        }
                        
                    }
                    
                    if showStory {
                        StoryPage()
                            .transition(.scale)
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
