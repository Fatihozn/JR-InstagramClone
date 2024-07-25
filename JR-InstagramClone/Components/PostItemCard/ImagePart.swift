//
//  ImagePart.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI

struct ImagePart: View {
    
    let width: CGFloat
    
    var body: some View {
        ZStack {
            Image(systemName: "house")
                .resizable()
                .scaledToFill()
                .frame(width: width)
                .background(.gray)
            
            VStack {
                HStack(alignment: .center) {
                    
                    StoryItemCard(size: width / 8)
                    
                    Text("Kullanıcı adı")
                        .foregroundStyle(.primary)
                    
                    Spacer()
                }
                .padding(8)
                Spacer()
            }
        }
    }
}
