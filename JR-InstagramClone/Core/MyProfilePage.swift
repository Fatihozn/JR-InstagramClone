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
    @State var pickerType: ImagePickerType = .post
    @State private var showActionSheet = false
    @State private var goToImagePicker = false
    @State private var Loading = false
    @State private var selectedSegment = 0
    let segments = ["squareshape.split.3x3", "play.square.stack"]
    
    @State var user: User?
    
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
                                
                                NavigationLink {
                                    ProfileEditPage()
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
                                showActionSheet = true
                            } label: {
                                Image(systemName: "plus.app")
                            }
                            .sheet(isPresented: $showActionSheet, content: {
                                VStack {
                                    Text("Oluştur")
                                        .font(.system(size: 18, weight: .bold))
                                    HStack {
                                        VStack(alignment: .leading) {
                                            MyProfileAddsButton(txt: "Reels Videosu", img: "play.square.stack.fill") {
                                                showActionSheet = false
                                                goToImagePicker = true
                                                pickerType = .reels
                                            }
                                            MyProfileAddsButton(txt: "Gönderi", img: "squareshape.split.3x3") {
                                                showActionSheet = false
                                                goToImagePicker = true
                                                pickerType = .post
                                            }
                                            MyProfileAddsButton(txt: "Hikaye", img: "face.dashed") {
                                                showActionSheet = false
                                                goToImagePicker = true
                                                pickerType = .story
                                            }
                                            
                                            MyProfileAddsButton(txt: "Öne Çıkan Hikaye", img: "heart.circle") {
                                                
                                            }
                                            MyProfileAddsButton(txt: "Canlı", img: "dot.radiowaves.left.and.right") {
                                                
                                            }
                                            MyProfileAddsButton(txt: "Senin için hazırlandı", img: "sparkles.rectangle.stack") {
                                                
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width)
                                .presentationDetents([.height(UIScreen.main.bounds.height / 2.5)])
                                .presentationDragIndicator(.visible)
                            })
                            
                            NavigationLink {
                                ProfileSettings(isDontLogin: $isDontLogin)
                            } label: {
                                Image(systemName: "text.justify")
                            }
                        }
                    }
                    .tint(.white)
                    .fullScreenCover(isPresented: $goToImagePicker) {
                        ZStack {
                            YPImagePickerView(Loading: $Loading, selectedTab: .constant(0), pickerType: pickerType)
                            
                            if Loading {
                                VStack {
                                    ProgressView()
                                        .frame(width: width, height: height)
                                }
                                .background(.black.opacity(0.5))
                                
                            }
                        }
                    }
                    
                } else {
                    ProgressView()
                        .frame(width: width, height: height)
                }
                
            }
            .onAppear {
                if let user = globalClass.User {
                    self.user = user
                    getPosts(user)
                }
            }
            
            
            
        }
        
    }
    
    private func MyProfileAddsButton(txt: String, img: String, completion: @escaping() -> ()) -> some View {
        Button {
            completion()
        } label: {
            Label(txt, systemImage: img)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
    }
    
    private func getPosts(_ user: User) {
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
                globalClass.User = user
                //self.user = user
            }
        }
    }
    
}

//#Preview {
//    MyProfilePage(isDontLogin: .constant(false))
//}



//struct MyProfileAddsItem: View {
//    var txt = ""
//    var img = ""
//
//    var body: some View {
//        Button {
//
//        } label: {
//            Label(txt, systemImage: img)
//        }
//        .padding(.vertical, 5)
//        .padding(.horizontal, 15)
//    }
//}
