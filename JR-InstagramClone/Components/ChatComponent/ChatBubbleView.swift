//
//  ChatBubbleView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 10.08.2024.
//

import SwiftUI

struct ChatBubbleView: View {
    var message: ChatMessage
    var isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            Text(message.text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill( isCurrentUser ? Color(hex: "#009000") : Color(hex: "#4F4F5f"))
                )
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: isCurrentUser ? .trailing : .leading)
                .lineLimit(nil)
            
            
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}


//struct ChatBubbleView: View {
//    var image: String
//    var message: String
//    var isCurrentUser: Bool
//
//    var body: some View {
//        HStack {
//            if isCurrentUser {
//                Spacer()
//            }
//            Text(message)
//                .padding()
//                .padding(isCurrentUser ? .trailing : .leading)
//                .background(
//                    Image(image)
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(isCurrentUser ? .green.opacity(0.8) : .secondary.opacity(0.8))
//                )
//                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: isCurrentUser ? .trailing : .leading)
//                .lineLimit(nil)
//
//
//
//
//            if !isCurrentUser {
//                Spacer()
//            }
//        }
//    }
//}
