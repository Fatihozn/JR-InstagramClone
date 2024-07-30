//
//  CoreView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI
import FirebaseAuth

struct RootPage: View {
    
    @State private var selectedTab = 0
    @State var isDontLogin = Auth.auth().currentUser != nil ? false : true
    
    @EnvironmentObject var globalClass: GlobalClass
    
    private var viewModel = HomeViewModel()
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            HomePage()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            SearchPage()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .fontWeight(selectedTab == 1 ? .bold : .light)
                }
                .tag(1)
            
            NewPostPage()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                }
                .tag(2)
            
            ReelsPage()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "play.square.stack.fill" : "play.square.stack")
                }
                .tag(3)
            
            MyProfilePage(isDontLogin: $isDontLogin)
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.circle.fill" : "person.circle")
                }
                .tag(4)
        }
        .onAppear {
            if let id = Auth.auth().currentUser?.uid {
                viewModel.getUserInfos(id: id) { result in
                    switch result {
                    case .success(let user):
                        globalClass.User = user
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .onChange(of: isDontLogin) { _, newValue in
            if newValue {
                selectedTab = 0
            }
        }
        .accentColor(.white)
        .sheet(isPresented: $isDontLogin) {
            LoginPage(isDontLogin: $isDontLogin)
                .interactiveDismissDisabled(true)
        }
        
    }
}

