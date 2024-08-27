//
//  ProfilePage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI
import Kingfisher

struct ProfilePage: View {
    
    @State var user: User?
    @Binding var isProfilePageActive: Bool
    
    @EnvironmentObject var globalClass: GlobalClass
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ProfilePageViewModel()
    
    @State private var selectedSegment = 0
    @State private var showSheet = false
    let segments = ["squareshape.split.3x3", "play.square.stack"]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                
                if let user {
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: width / 12) {
                                StoryItemCard(user: user, size: width / 4, isShowStory: true, isProfilePageActive: .constant(false))
                                ProfileNumber_text(number: user.posts.count, text: "gönderi")
                                ProfileNumber_text(number: user.followers.count, text: "takipçi")
                                ProfileNumber_text(number: user.following.count, text: "takip")
                                
                            }
                            
                            if user.name_Lname != "" {
                                Text(user.name_Lname)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                    .padding(.top, 2)
                            }
                            if user.biography != "" {
                                Text(user.biography)
                            }
                            if user.titles != ""{
                                Text(user.titles)
                            }
                            if user.gender != ""{
                                Text(user.gender)
                            }
                            
                            HStack(alignment: .center) {
                                Spacer()
                                Group {
                                    if let mainUser = globalClass.User {
                                        if mainUser.following.contains(user.id ?? "") {
                                            followingButton(width, mainUser: mainUser, user: user)
                                            
                                        } else if mainUser.followers.contains(user.id ?? "") && !mainUser.following.contains(user.id ?? "") {
                                            followBackButton(width, mainUser: mainUser, user: user)
                                            
                                        } else {
                                            followButton(width, mainUser: mainUser, user: user)
                                        }
                                    }
                                    
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("Mesaj")
                                        .ProfileButtonStyle(size: width / 2.4, color: Color.secondary.opacity(0.5))
                                        .contentShape(Rectangle())
                                }
                                
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "person.badge.plus")
                                        .padding(5)
                                        .background(Color.secondary.opacity(0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .contentShape(Rectangle())
                                }
                                
                                Spacer()
                            }
                            
                        }
                        .padding(.horizontal, 3)
                        
                        Section {
                            if user.posts.count != 0 {
                                LazyVGrid(columns: [
                                    GridItem(.flexible(minimum: width / 3.1, maximum: width / 3)),
                                    GridItem(.flexible(minimum: width / 3.1, maximum: width / 3)),
                                    GridItem(.flexible(minimum: width / 3.1, maximum: width / 3))]) {
                                        
                                        ForEach(user.posts.indices, id: \.self) { index in
                                            NavigationLink {
                                                PostsDetailList(posts: user.posts, index: index)
                                            } label: {
                                                KFImage(URL(string: user.posts[index].photoUrl))
                                                    .resizable()
                                                    .frame(width: width / 3.1, height: width / 3.1)
                                                    .scaledToFill()
                                                    .id(index)
                                            }
                                            
                                        }
                                    }
                            } else {
                                VStack {
                                    Text("Hiç Gönderi Yok")
                                }
                            }
                        } header: {
                            
                            Picker("", selection: $selectedSegment) {
                                ForEach(0 ..< 2){ i in
                                    Image(systemName: segments[i]).tag(i)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.top)
                            
                        }
                    }
                    .navigationTitle(user.username)
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                isProfilePageActive = true
                
                if let user {
                    let dispatchGroup = DispatchGroup()
                    if let postIDs = user.postIDs {
                        user.posts.removeAll()
                        for item in postIDs {
                            dispatchGroup.enter()
                            viewModel.downloadPostImages(postID: item) { post in
                                user.posts.append(post)
                                dispatchGroup.leave()
                            }
                        }
                        dispatchGroup.notify(queue: .main) {
                            self.user = user
                        }
                    }
                }
                
            }
            .onDisappear {
                isProfilePageActive = false
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Geri git
                    }) {
                        Image(systemName: "chevron.left") // Geri butonu simgesi
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    if let user {
                        if user.following.contains(String(globalClass.User?.id ?? "")) {
                            Button {
                                
                            } label: {
                                Image(systemName: "bell")
                            }
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .tint(.white)
        }
        
    }
    
    private func updateUserFollowers(id: String) {
        viewModel.getUserInfos(id: id) { user in
            DispatchQueue.main.async {
                self.user?.followers = user?.followers ?? []
            }
        }
    }
    private func followingButton(_ width: CGFloat, mainUser: User, user: User) -> some View {
        Button {
            showSheet = true
        } label: {
            HStack {
                Text("Takiptesin")
                Image(systemName: "chevron.down")
                    .font(.system(size: 14))
            }
            .ProfileButtonStyle(size: width / 2.4, color: Color.secondary.opacity(0.5))
            .contentShape(Rectangle())
        }
        .sheet(isPresented: $showSheet, content: {
            VStack {
                Text(user.username)
                    .font(.system(size: 18, weight: .bold))
                HStack {
                    VStack(alignment: .leading) {
                        SheetButton(txt: "Yakın Arkadaş Listesine Ekle", img: "star.circle", imageIsRight: true) {
                            
                        }
                        SheetButton(txt: "Favorilere Ekle", img: "star", imageIsRight: true) {
                            
                        }
                        SheetButton(txt: "Sessize Al", img: "chevron.right", imageIsRight: true) {
                            
                        }
                        
                        SheetButton(txt: "Kısıtla", img: "chevron.right", imageIsRight: true) {
                            
                        }
                        SheetButton(txt: "Takibi Bırak", img: "") {
                            if let mainUser = globalClass.User {
                                removeFromLists(mainUser: mainUser, friendUser: user)
                            }
                            
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .presentationDetents([.height(UIScreen.main.bounds.height / 2.5)])
            .presentationDragIndicator(.visible)
        })
    }
    
    private func followBackButton(_ width: CGFloat, mainUser: User, user: User) -> some View {
        Button {
            addToFollowingList(user: mainUser, friend: user)
            addToFollowersList(user: user, friendID: mainUser.id ?? "")
            
        } label: {
            Text("Sen de takip Et")
                .ProfileButtonStyle(size: width / 2.4, color: Color.blue)
                .contentShape(Rectangle())
        }
    }
    
    private func followButton(_ width: CGFloat, mainUser: User, user: User) -> some View {
        Button {
            addToFollowingList(user: mainUser, friend: user)
            addToFollowersList(user: user, friendID: mainUser.id ?? "")
            
        } label: {
            Text("Takip Et")
                .ProfileButtonStyle(size: width / 2.4, color: Color.blue)
                .contentShape(Rectangle())
        }
    }
    
    
    
    // MARK: - Action funcs
    
    private func removeFromLists(mainUser: User, friendUser: User) {
        
        viewModel.removeFromList(friendUser.followers, userId: friendUser.id ?? "", friendId: mainUser.id ?? "", dataName: "followers") { updated in
            if updated {
                print("followers güncellendi")
                updateUserFollowers(id: friendUser.id ?? "")
            }
        }
        
        viewModel.removeFromList(mainUser.following, userId: mainUser.id ?? "", friendId: friendUser.id ?? "", dataName: "following") { updated in
            if updated {
                print("following güncellendi")
                globalClass.updatedMainUser(id: mainUser.id ?? "")
            }
        }
        
    }
    
    private func addToFollowersList(user: User, friendID: String) {
        // buraya gönderilen user profilini görüntülediğimiz user
        viewModel.addToList(user.followers, userId: user.id ?? "", friendId: friendID, dataName: "followers") { updated in
            print("followers listesine eklendi: \(updated)")
            updateUserFollowers(id: friendID)
        }
    }
    
    private func addToFollowingList(user: User, friend: User) {
        // buraya gönderilen user giriş yapmış ve karşı kullanıcının profilini görüntüleyen user
        viewModel.addToList(user.following, userId: user.id ?? "", friendId: friend.id ?? "", dataName: "following") { updated in
            if updated {
                viewModel.addToChats(user1Id: user.id ?? "", user2Id: friend.id ?? "", user1Chats: user.chats ?? [], user2Chats: friend.chats ?? [])
                globalClass.updatedMainUser(id: user.id ?? "")
            }
        }
    }
    
    
}

//#Preview {
//    ProfilePage()
//}
