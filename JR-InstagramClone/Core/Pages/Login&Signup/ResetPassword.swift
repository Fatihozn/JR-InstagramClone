//
//  ResetPassword.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 27.07.2024.
//

import SwiftUI

struct ResetPassword: View {
    
    @State private var email = ""
    
    @ObservedObject private var viewModel = Login_SignupViewModel()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack {
                Image("instagram")
                    .resizable()
                    .frame(width: width / 2, height: width / 6)
                    .padding(.vertical)
                
                LoginTextField(text: $email, placeHolder: "E-posta", size: width / 1.2)
                    .padding(.vertical, 10)
                
                Button{
                    
                    viewModel.resetPassword(email: email)
                    
                } label: {
                    Text("Mail Gönder")
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundStyle(.white)
                        .frame(width: width / 1.2)
                        .background(.blue.opacity(0.9))
                        .cornerRadius(8)
                    
                }
                .contentShape(Rectangle())
                
                Spacer()
                    .frame(height: height / 6)
                
            }
            .frame(width: width, height: height)
            .onTapGesture {
                hideKeyboard()
            }
            .background(
                LinearGradient(gradient: Gradient(
                    colors: [Color(hex: "#405DE6"), Color(hex: "#833AB4"), Color(hex: "#C13584"),Color(hex: "#F77737"), Color(hex: "#FCAF45")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
        }
        
    }
}

#Preview {
    ResetPassword()
}
