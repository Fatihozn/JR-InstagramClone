//
//  SignupPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI

struct SignupPage: View {
    
    @State var email = ""
    @State var name_surname = ""
    @State var username = ""
    @State var password = ""
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var viewModel = Login_SignupViewModel()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ScrollView {
                VStack {
                    
                    Spacer()
                        .frame(height: height / 9)
                    
                    VStack {
                        VStack {
                            Image("instagram")
                                .resizable()
                                .frame(width: width / 2, height: width / 6)
                                .padding(.vertical)
                            
                            Text("Arkadaşlarının fotoğraf ve videolarını görmek için kaydol.")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .frame(width: width / 1.2)
                                .padding(.bottom)
                        }
                        
                        VStack {
                            
                            LoginTextField(text: $email, placeHolder: "E-posta", size: width / 1.2)
                                .padding(.vertical, 10)
                            
                            LoginTextField(text: $name_surname, placeHolder: "Adı Soyadı", size: width / 1.2)
                                .padding(.bottom, 10)
                            
                            LoginTextField(text: $username, placeHolder: "Kullanıcı Adı", size: width / 1.2)
                                .padding(.bottom, 10)
                            
                            LoginTextField(text: $password, placeHolder: "Şifre", size: width / 1.2)
                                .padding(.bottom, 15)
                        }
                        
                        VStack {
                            Button{
                                viewModel.createUser(email: email, password: password)
                            } label: {
                                Text("Kaydol")
                                    .fontWeight(.bold)
                            }
                            .padding(10)
                            .foregroundStyle(.white)
                            .frame(width: width / 1.2)
                            .background(.blue.opacity(0.9))
                            .cornerRadius(8)
                            .padding(.bottom, 24)
                            
                            Text("Kaydolarak, Koşullar'ı, Veri İlkesi'ni ve Çerezler İlkesi'ni kabul etmiş olursunuz.")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .frame(width: width / 1.2)
                        }
                       
                        
                    }
                    
                    Spacer()
                    
                    VStack {
                        Divider()
                            .frame(height: 2)
                            .background(.white.opacity(0.5))
                            
                        
                        HStack {
                            Text("Hesabınız var mı ?")
                                .foregroundStyle(.white.opacity(0.7))
                            
                            Button {
                                withAnimation {
                                    dismiss()
                                }
                            } label: {
                                Text("Giriş Yap")
                                    .foregroundStyle(.white)
                            }
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
        }
    }
}

#Preview {
    SignupPage()
}
