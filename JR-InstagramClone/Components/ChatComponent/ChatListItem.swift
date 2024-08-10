//
//  ChatListItem.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 10.08.2024.
//

import SwiftUI
import Kingfisher

struct ChatListItem: View {
    
    var chat: Chat
    
    var body: some View {
        NavigationLink {
            ChatPage(chat: chat)
        } label: {
            HStack {
                KFImage(URL(string: chat.user?.profilePhoto?.photoUrl ?? ""))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                
                Text(chat.user?.username ?? "")
                    .fontWeight(.bold)
            }
        }
    }
}
