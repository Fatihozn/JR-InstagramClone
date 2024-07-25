//
//  MyStoryItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI


struct MyStoryItemCard: View {
    
    let size: CGFloat
    var text: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(
//                    Circle().stroke(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.purple, Color.pink, Color.red, Color.orange, Color.yellow]),
//                            startPoint: .topTrailing,
//                            endPoint: .bottomLeading
//                        ),
//                        lineWidth: 4
//                    )
                   EmptyView() )
                .overlay(
                    ZStack {
                        Circle()
                            .stroke(.black, lineWidth: 8)
                            .fill(Color.blue)
                            .frame(width: 30, height: 30)
                        Text("+")
                            .foregroundColor(.white)
                            .font(.system(size: 26))
                            .bold()
                    }
                        .offset(x: 35, y: 35)
                )
            if text != "" {
                Text(text)
            }
            
            
        }
    }
}
