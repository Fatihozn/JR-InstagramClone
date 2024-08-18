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
            
            HStack(alignment: .bottom) {
                Text(message.text)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(message.timestamp.hourFormat())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 5)
            }
            
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill( isCurrentUser ? Color(hex: "#7a67ee") : Color(hex: "#4F4F5f"))
            )
            .frame(maxWidth: UIScreen.main.bounds.width * 0.70, alignment: isCurrentUser ? .trailing : .leading)
            .lineLimit(nil)
            
            
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}

