//
//  ProfileNumber_text.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI

struct ProfileNumber_text: View {
    
    var number: Int
    var text: String
    
    var body: some View {
        VStack {
            Text(String(number))
                .foregroundStyle(.primary)
            Text(text)
                .foregroundStyle(.secondary)
        }
    }
}

struct ProfileButton: View {
    
    var size: CGFloat
    var text: String
    var image: String = ""
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Text(text)
                if image != "" {
                    Image(systemName: image)
                        .font(.system(size: 14))
                }
            }
        }
        .fontWeight(.bold)
        .padding(.vertical, 6)
        .foregroundStyle(.white)
        .frame(width: size)
        .background(Color.secondary.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
