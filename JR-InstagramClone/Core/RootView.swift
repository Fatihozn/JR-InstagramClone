//
//  CoreView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                  Image(systemName: "magnifyingglass")
                        .fontWeight(selectedTab == 1 ? .bold : .light)
                }
                .tag(1)
            
            NewPostView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                }
                .tag(2)
            
            ReelsView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "play.square.stack.fill" : "play.square.stack")
                }
                .tag(3)
            
            MyProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.circle.fill" : "person.circle")
                }
                .tag(4)
        }
        .accentColor(.white)
    }
}

