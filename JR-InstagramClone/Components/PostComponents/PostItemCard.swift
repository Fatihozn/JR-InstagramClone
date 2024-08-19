//
//  PostItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI
import Kingfisher

struct PostItemCard: View {
    
    @Binding var post: Post
    let width: CGFloat
    var showProfile = true
    @State var isUpdated: Bool = false
    @State var isLiked: Bool = false
    @State var isSaved: Bool = false
    
    @EnvironmentObject var globalClass: GlobalClass
    @ObservedObject private var viewModel = PostViewModel()
    
    var body: some View {
        VStack {
            
            imagePart()
                .onTapGesture(count: 2) {
                    likeButton()
                }
            actionsPart()
            infoPart()
            
        }
        .onAppear {
            defineIsLiked()
            defineIsSaved()
        }
        .onChange(of: isUpdated) {
            withAnimation {
                defineIsLiked()
                defineIsSaved()
            }
        }
        .padding(.top)
        .padding(.bottom, 10)
    }
    
    // MARK: - Views
    
    private func imagePart() -> some View {
        VStack {
            
            if showProfile {
                VStack {
                    HStack(alignment: .center) {
                        
                        StoryItemCard(user: post.user, size: width / 9, isProfilePageActive: .constant(false))
                        
                        Text(post.user?.username ?? "")
                            .foregroundStyle(.primary)
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            
            KFImage(URL(string: post.photoUrl))
                .resizable()
                .scaledToFill()
                .frame(width: width)
            
            
        }
    }
    
    private func actionsPart() -> some View {
        HStack {
            HStack {
                Button {
                    likeButton()
                } label: {
                    if isLiked {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 28, height: 26) // İstediğiniz boyutlara ayarlayın
                            .scaledToFit()
                            .foregroundStyle(.red)
                        
                    } else {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 28, height: 26) // İstediğiniz boyutlara ayarlayın
                            .scaledToFit()
                    }
                    
                }
                
                Button {
                    
                    // beğenenleri görüntüle
                    
                } label: {
                    Text("\(String(describing: post.byLiked?.count ?? 0))")
                        .foregroundStyle(.primary)
                }
            }
            .padding(3)
            .padding(.trailing, 5)
            
            
            HStack {
                Button {
                    
                } label: {
                    Image("postChat")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                }
                
                Button {
                    
                    // beğenenleri görüntüle
                    
                } label: {
                    Text("145")
                        .foregroundStyle(.primary)
                }
            }
            .padding(3)
            .padding(.trailing, 5)
            
            Button {
                
            } label: {
                Image("send")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 26, height: 26) // İstediğiniz boyutlara ayarlayın
                    .scaledToFit()
                    .padding(3)
            }
            
            Spacer()
            
            Button {
                saveButton()
            } label: {
                if isSaved {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .frame(width: 24, height: 28)
                        .scaledToFit()
                        .padding(3)
                } else {
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 24, height: 28)
                        .scaledToFit()
                        .padding(3)
                }
                
            }
        }
        .padding(.horizontal, 3)
    }
    
    private func infoPart() -> some View {
        HStack {
            VStack(alignment: .leading) {
                //                Button {
                //
                //                    // beğenenleri görüntüle
                //
                //                } label: {
                //                    Text("\(String(describing: post.byLiked?.count ?? 0)) beğenme")
                //                        .foregroundStyle(.primary)
                //                }
                
                Button {
                    
                } label: {
                    Text("kendi yorumu")
                        .foregroundStyle(.primary)
                }
                
                Button {
                    
                } label: {
                    Text("Tüm yorumları gör")
                        .foregroundStyle(.secondary)
                }
                
                Text(post.timestamp.timeDifference())
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
        }
        .frame(width: width)
    }
    
    // MARK: - Define Button State
    
    private func defineIsLiked() {
        if let likes = post.byLiked {
            if likes.contains(globalClass.User?.id ?? "") {
                isLiked = true
            } else {
                isLiked = false
            }
        } else {
            isLiked = false
        }
    }
    
    private func defineIsSaved() {
        if let savedList = globalClass.User?.savedList {
            if savedList.contains(post.id ?? "") {
                isSaved = true
            } else {
                isSaved = false
            }
        } else {
            isSaved = false
        }
    }
    
    // MARK: - Actions
    
    private func updatePostData(_ newList: [String]) {
        viewModel.updatePostData(id: post.id ?? "", dataName: "byLiked", newValue: newList) { message in
            if message == "Güncellendi" {
                viewModel.downloadPostImage(id: post.id ?? "") { newByLiked in
                    DispatchQueue.main.async {
                        self.post.byLiked = newByLiked
                        isUpdated.toggle()
                    }
                    
                }
            }
        }
    }
    
    private func updateUserInfos(_ newList: [String]) {
        viewModel.updateUserInfos(id: globalClass.User?.id ?? "", dataName: "savedList", newValue: newList) { message in
            if message == "Güncellendi" {
                globalClass.updatedMainUser(id: globalClass.User?.id ?? "") { response in
                    isUpdated.toggle()
                }
            }
        }
    }
    
    private func likeButton() {
        if isLiked {
            if var newLikes = post.byLiked {
                if let index = newLikes.firstIndex(of: globalClass.User?.id ?? "") {
                    newLikes.remove(at: index)
                    updatePostData(newLikes)
                }
            }
        } else {
            if var newLikes = post.byLiked {
                newLikes.append(globalClass.User?.id ?? "")
                updatePostData(newLikes)
            } else {
                var newLikes: [String] = []
                newLikes.append(globalClass.User?.id ?? "")
                updatePostData(newLikes)
            }
        }
    }
    
    private func saveButton() {
        if isSaved {
            if var newSavedList = globalClass.User?.savedList {
                if let index = newSavedList.firstIndex(of: post.id ?? "") {
                    newSavedList.remove(at: index)
                    updateUserInfos(newSavedList)
                }
            }
        } else {
            if var newSavedList = globalClass.User?.savedList {
                newSavedList.append(post.id ?? "")
                updateUserInfos(newSavedList)
            } else {
                var newSavedList: [String] = []
                newSavedList.append(post.id ?? "")
                updateUserInfos(newSavedList)
            }
        }
    }
    
}

