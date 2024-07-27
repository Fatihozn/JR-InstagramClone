//
//  CustomTextFields.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 26.07.2024.
//

import SwiftUI

struct LoginTextField: View {
    
    @Binding var text: String
    var placeHolder: String
    var size: CGFloat
    
    var body: some View {
        TextField("", text: $text, prompt: Text(placeHolder).foregroundStyle(.gray))
        .padding(10)
        .foregroundStyle(.black)
        .frame(width: size)
        .background(.white)
        .cornerRadius(8)
    }
}
