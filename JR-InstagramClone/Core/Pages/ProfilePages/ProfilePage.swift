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
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ProfilePageViewModel()
    
    @State private var selectedSegment = 0
    let segments = ["squareshape.split.3x3", "play.square.stack", "person.crop.square"]
    
    @State var isFollowing = false
    @Binding var isProfilePageActive: Bool
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                
                if let user {
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: width / 12) {
                                StoryItemCard(user: user, size: width / 4, isShowStory: true, isProfilePageActive: .constant(false))
                                ProfileNumber_text(number: 7, text: "gönderi")
                                ProfileNumber_text(number: user.followers, text: "takipçi")
                                ProfileNumber_text(number: user.following, text: "takip")
                                
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
                                    if isFollowing {
                                        Button {
                                            
                                        } label: {
                                            HStack {
                                                Text("Takiptesin")
                                                Image(systemName: "chevron.down")
                                                    .font(.system(size: 14))
                                            }
                                            .ProfileButtonStyle(size: width / 2.4, color: Color.secondary.opacity(0.5))
                                            .contentShape(Rectangle())
                                        }
                                        
                                        
                                    } else {
                                        Button {
                                            isFollowing = true
                                        } label: {
                                            Text("Takip Et")
                                                .ProfileButtonStyle(size: width / 2.4, color: Color.blue)
                                                .contentShape(Rectangle())
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
                                        
                                        ForEach(user.posts, id: \.self) { post in
                                            KFImage(URL(string: post.photoUrl))
                                                .resizable()
                                                .frame(width: width / 3.1, height: width / 3.1)
                                                .scaledToFill()
                                        }
                                    }
                            } else {
                                VStack {
                                    Text("Hiç Gönderi Yok")
                                }
                            }
                        } header: {
                            
                            Picker("", selection: $selectedSegment) {
                                ForEach(0 ..< segments.count){ i in
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
                    
                    if isFollowing {
                        Button {
                            
                        } label: {
                            Image(systemName: "bell")
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
}

//#Preview {
//    ProfilePage()
//}
