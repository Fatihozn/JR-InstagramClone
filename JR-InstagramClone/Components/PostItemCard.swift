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
    @State var isUpdated: Bool = false
    @State var isLiked: Bool = false
    
    @EnvironmentObject var globalClass: GlobalClass
    @ObservedObject private var viewModel = PostViewModel()
    
    var body: some View {
        VStack {
            
            imagePart()
            actionsPart()
            infoPart()
                .padding(.bottom)
            
        }
        .onAppear {
            withAnimation {
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
        }
        .onChange(of: isUpdated) {
            withAnimation {
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
        }
    }
    
    // MARK: - Views
    
    private func imagePart() -> some View {
        ZStack {
            KFImage(URL(string: post.photoUrl))
                .resizable()
                .scaledToFill()
                .frame(width: width)
            
            
            VStack {
                HStack(alignment: .center) {
                  
                    StoryItemCard(user: post.user, size: width / 8, isSeenStory: true, isProfilePageActive: .constant(false))
                    
                    Text(post.user?.username ?? "")
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                        
                    Spacer()
                }
                .padding(8)
               // .background(.black.opacity(0.1))
                Spacer()
            }
        }
    }
    
    private func actionsPart() -> some View {
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
                        .padding(3)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 28, height: 26) // İstediğiniz boyutlara ayarlayın
                        .scaledToFit()
                        .padding(3)
                }
                
            }
            
            Button {
                
            } label: {
                Image("postChat")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 36, height: 36)
                    .scaledToFit()
                    .padding(3)
                
            }
            
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
                
            } label: {
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 24, height: 28) // İstediğiniz boyutlara ayarlayın
                    .scaledToFit()
                    .padding(3)
            }
        }
        .padding(.horizontal, 3)
    }
    
    private func infoPart() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Button {
                    
                    // beğenenleri görüntüle
                    
                } label: {
                    Text("\(String(describing: post.byLiked?.count ?? 0)) beğenme")
                        .foregroundStyle(.primary)
                }
                
                //                 Button {
                //
                //                 } label: {
                //                     Text("kendi yorumu")
                //                         .foregroundStyle(.primary)
                //                 }
                //
                Button {
                    
                } label: {
                    Text("165 yorumun tümünü gör")
                        .foregroundStyle(.secondary)
                }
                
                Text(post.timestamp.dateFormat())
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
        }
        .frame(width: width)
    }
    
    
    // MARK: - Actions
    
    private func updatePostData(_ newLikes: [String]) {
        viewModel.updatePostData(id: post.id ?? "", dataName: "byLiked", newValue: newLikes) { message in
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
    
}

