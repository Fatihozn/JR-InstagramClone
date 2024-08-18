//
//  PostItemList.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 13.08.2024.
//

import SwiftUI

struct PostsDetailList: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var posts: [Post]
    var index: Int
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                ForEach(posts.indices, id: \.self) { index in
                    PostItemCard(post: $posts[index], width: UIScreen.main.bounds.width, showProfile: false)
                        .id(index)
                }
                .onAppear {
                    proxy.scrollTo(index)
                }
            }
        }
        .navigationTitle("Gönderiler")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
        
    }
}
