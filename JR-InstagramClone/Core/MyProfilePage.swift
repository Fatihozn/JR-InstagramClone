//
//  ProfileView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI
import Kingfisher

struct MyProfilePage: View {
    
    @Binding var isDontLogin: Bool
    @Binding var isUploaded: Bool
    
    @State var isUpdated: Bool = false
    
    @State private var selectedSegment = 0
    let segments = ["squareshape.split.3x3", "play.square.stack", "person.crop.square"]
    
    
    @EnvironmentObject var globalClass: GlobalClass
    @ObservedObject private var viewModel = MyProfileViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                
                if let user = globalClass.User {
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: width / 10) {
                                MyStoryItemCard(size: width / 4)
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
                                
                                NavigationLink {
                                    ProfileEditPage(isUpdated: $isUpdated)
                                } label: {
                                    Text("Düzenle")
                                        .ProfileButtonStyle(size: width / 2.3, color: Color.secondary.opacity(0.5))
                                        .contentShape(Rectangle())
                                }
                                
                                
                                Button {
                                    
                                } label: {
                                    Text("Profili paylaş")
                                        .ProfileButtonStyle(size: width / 2.3, color: Color.secondary.opacity(0.5))
                                        .contentShape(Rectangle())
                                }
                                
                                
                                Spacer()
                            }
                            .padding(.top, 5)
                            
                        }
                        .padding(.horizontal, 3)
                        
                        Section {
                            if user.posts.count != 0 {
                                LazyVGrid(columns: [
                                    GridItem(.flexible(minimum: width / 3.1, maximum: width / 3)),
                                    GridItem(.flexible(minimum: width / 3.1, maximum: width / 3)),
                                    GridItem(.flexible(minimum: width / 3.1, maximum: width / 3))]) {
                                        
                                        ForEach(user.posts, id: \.id) { post in
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
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                
                            } label: {
                                HStack {
                                    Text(user.username)
                                        .font(.title2)
                                    Image(systemName: "chevron.down")
                                    
                                }
                            }
                        }
                        
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "plus.app")
                            }
                            
                            NavigationLink {
                                ProfileSettings(isDontLogin: $isDontLogin)
                            } label: {
                                Image(systemName: "text.justify")
                            }
                        }
                    }
                    .tint(.white)
                    
                } else {
                    ProgressView()
                        .frame(width: width, height: height)
                }
                
            }
            .onChange(of: isUpdated, {
                if let user = globalClass.User  {
                   getPosts(user)
                }
            })
            .onAppear {
                if let user = globalClass.User {
                    if isUploaded {
                      getPosts(user)
                    }
                }
            }
            
            
        }
        
    }
    
    
    private func getPosts(_ user: User) {
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
                globalClass.User = user
                //self.user = user
            }
            isUploaded = false
        }
    }
    
}

//#Preview {
//    MyProfilePage(isDontLogin: .constant(false))
//}
