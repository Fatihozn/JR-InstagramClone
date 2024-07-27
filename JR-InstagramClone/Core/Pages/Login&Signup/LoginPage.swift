//
//  LoginPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    
    @State var email = "fatih@gmail.com"
    @State var password = "123456"
    
    @State var goToSignup = false
    
    @ObservedObject private var viewModel = Login_SignupViewModel()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ScrollView {
                VStack {
                    
                    Spacer()
                        .frame(height: height / 5)
                    
                    VStack {
                        
                        Image("instagram")
                            .resizable()
                            .frame(width: width / 2, height: width / 6)
                            .padding(.vertical)
                        
                        LoginTextField(text: $email, placeHolder: "E-posta", size: width / 1.2)
                            .padding(.vertical, 10)
                        
                        LoginTextField(text: $password, placeHolder: "Şifre", size: width / 1.2)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Şifremi Unuttum ?")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        }
                        .frame(width: width / 1.2)
                        .padding(.bottom)
                        
                        Button{
                           // viewModel.signIn(email: mail, password: password)
//                            signInUser(email: mail, password: password) { result in
//                                print(result)
//                            }
                        } label: {
                            Text("Giriş Yap")
                                .fontWeight(.bold)

                        }
                        .padding(10)
                        .foregroundStyle(.white)
                        .frame(width: width / 1.2)
                        .background(.blue.opacity(0.9))
                        .cornerRadius(8)
                        
                    }
                    
                    Spacer()
                    
                    Divider()
                        .frame(height: 2)
                        .background(.white.opacity(0.5))
                        
                    
                    HStack {
                        Text("Hesabınız yok mu ?")
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Button {
                            withAnimation {
                                goToSignup.toggle()
                            }
                        } label: {
                            Text("Kaydol")
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
                .frame(width: width, height: height)
            }
            .onTapGesture {
                    hideKeyboard()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: 
                            [Color(hex: "#405DE6"), Color(hex: "#833AB4"), Color(hex: "#C13584"),
                             Color(hex: "#F77737"), Color(hex: "#FCAF45")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .sheet(isPresented: $goToSignup) {
                SignupPage()
            }
        }
    }
}

#Preview {
    LoginPage()
}
