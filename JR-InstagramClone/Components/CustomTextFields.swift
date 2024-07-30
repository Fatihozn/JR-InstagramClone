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
    var isMail: Bool = false
    
    var body: some View {
        HStack {
            
            TextField("", text: $text, prompt: Text(placeHolder).foregroundStyle(.gray))
                
            if text.isEmpty || isMail && !text.isValidEmail(){
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.red)
            }
            
        }
        .LoginTextFieldStyle(size: size)
        
    }
}


struct PasswordTextField: View {
    
    @Binding var text: String
    var placeHolder: String
    var size: CGFloat
    
    @State var show = false
    
    var body: some View {
        HStack {
            Group {
                if show {
                    TextField("", text: $text, prompt: Text(placeHolder).foregroundStyle(.gray))
                } else {
                    SecureField("", text: $text, prompt: Text(placeHolder).foregroundStyle(.gray))
                }
            }
            
            if text.isEmpty || text.count < 6{
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.red)
            }
            
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Image(systemName: show ? "eye.slash" : "eye")
                    .foregroundColor(.black)
            }
        }
        .LoginTextFieldStyle(size: size)
        
        
    }
}
