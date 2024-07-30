//
//  SignupPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI

struct SignupPage: View {
    
    @State private var email = ""
    @State private var name_Lname = ""
    @State private var username = ""
    @State private var password = ""
    
    @State private var showAlert = false
    @State private var errorText = ""
    
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
                            
                            LoginTextField(text: $email, placeHolder: "E-posta", size: width / 1.2, isMail: true)
                                .padding(.vertical, 10)
                            
                            LoginTextField(text: $name_Lname, placeHolder: "Adı Soyadı", size: width / 1.2)
                                .padding(.bottom, 10)
                            
                            LoginTextField(text: $username, placeHolder: "Kullanıcı Adı", size: width / 1.2)
                                .padding(.bottom, 10)
                            
                            PasswordTextField(text: $password, placeHolder: "Şifre", size: width / 1.2)
                                .padding(.bottom, 15)
                        }
                        
                        VStack {
                            Button{
                                checkInfos()
                            } label: {
                                Text("Kaydol")
                                    .fontWeight(.bold)
                                    .padding(10)
                                    .frame(width: width / 1.2)
                                    .foregroundStyle(.white)
                                    .background(.blue.opacity(0.9))
                                    .cornerRadius(8)
                                    .padding(.bottom, 24)
                            }
                            .contentShape(Rectangle())
                            
                            
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
            .alert(isPresented: $showAlert, content: {
                AlertFuncs.createOneButtonAlert(title: "Uyarı!", description: errorText)
            })
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
    
    private func checkInfos() {
        if email != "" && name_Lname != "" && username != "" && password != "" {
            if email.isValidEmail() {
                if password.count > 5 {
                    viewModel.createUser(email: email, password: password, username: username, name_Lname: name_Lname) { text in
                        
                        if text == "Kayıt Başarılı" {
                            dismiss()
                        } else {
                            errorText = text
                            showAlert = true
                        }
                    }
                } else {
                    errorText = "Şifreniz en az 6 karakterden oluşmalıdır."
                    showAlert = true
                }
            } else {
                errorText = "Lütfen geçerli bir mail adresi giriniz."
                showAlert = true
            }
        } else {
            errorText = "Gerekli alanları lütfen doldurunuz."
            showAlert = true
        }
    }
    
}

//#Preview {
//    SignupPage()
//}
