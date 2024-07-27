//
//  ProfileButtonStyle.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI

extension View {
    func ProfileButtonStyle(size: CGFloat, color: Color) -> some View {
        self.modifier(ProfileButtonModifier(size: size, color: color))
    }
    
//    func LoginTextFieldStyle(size: CGFloat) -> some View {
//        self.modifier(LoginTextFieldModifier(size: size))
//    }
}

struct ProfileButtonModifier: ViewModifier {
    var size: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .padding(.vertical, 6)
            .foregroundStyle(.white)
            .frame(width: size)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

//struct LoginTextFieldModifier: ViewModifier {
//    var size: CGFloat
//    
//    func body(content: Content) -> some View {
//        content
//            .padding(10)
//            .foregroundStyle(.black)
//            .frame(width: size)
//            .background(.white)
//            .cornerRadius(8)
//    }
//}


