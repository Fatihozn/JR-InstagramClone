//
//  MyStoryItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI
import Kingfisher

struct MyStoryItemCard: View {
    
    let size: CGFloat
    var text: String = ""
    //var photoUrl: String = ""
    
    @EnvironmentObject var globalClass: GlobalClass
    
    var body: some View {
        VStack {
            Group {
                if let photoUrl = globalClass.User?.profilePhoto?.photoUrl {
                    KFImage(URL(string: photoUrl))
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                }
            }
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(
//                    Circle().stroke(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color(hex: "#405DE6"), Color(hex: "#833AB4"), Color(hex: "#C13584"),
//                    Color(hex: "#F77737"), Color(hex: "#FCAF45")]),
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
