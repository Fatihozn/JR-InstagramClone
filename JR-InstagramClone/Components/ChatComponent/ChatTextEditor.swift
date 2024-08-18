//
//  ChatTextEditor.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 10.08.2024.
//

import SwiftUI

struct ChatTextEditor: View {
    @Binding var text: String
    var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        TextEditor(text: $text)
            .padding(.horizontal)
            .scrollContentBackground(.hidden)
            .background(Color(hex: "#4F4F4F")) // Color(hex: "#4F4F4F")
            .frame(height: height, alignment: .topLeading)
            .cornerRadius(20)
            .autocapitalization(.words)
            .disableAutocorrection(true)
            .font(.system(size: 16))
            .scrollIndicators(.hidden)
            .tint(.white)
            .onChange(of: text) {_, newValue in
                let size = CGSize(width: width, height: .infinity)
                let estimatedSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil).size
                height = max(estimatedSize.height, 40) // Minimum yüksekliği 50 olarak ayarla
            }
    }
}

#Preview {
    ChatTextEditor(text: .constant("asdf"), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
}
