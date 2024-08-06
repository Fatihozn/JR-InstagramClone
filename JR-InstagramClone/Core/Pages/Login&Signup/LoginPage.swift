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
    @State private var goToResetPassword = false
    @State private var showAlert = false
    @State private var errorText = ""
    
    @Binding var isDontLogin: Bool
    @Binding var user: User?
    
    @EnvironmentObject var globalClass: GlobalClass
    
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
                        
                        LoginTextField(text: $email, placeHolder: "E-posta", size: width / 1.2, isMail: true)
                            .padding(.vertical, 10)
                        
                        PasswordTextField(text: $password, placeHolder: "Şifre", size: width / 1.2)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Spacer()
                            Button {
                                goToResetPassword = true
                            } label: {
                                Text("Şifremi Unuttum ?")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        }
                        .frame(width: width / 1.2)
                        .padding(.bottom)
                        
                        Button{
                            checkInfos()
                        } label: {
                            Text("Giriş Yap")
                                .fontWeight(.bold)
                                .padding(10)
                                .foregroundStyle(.white)
                                .frame(width: width / 1.2)
                                .background(.blue.opacity(0.9))
                                .cornerRadius(8)
                            
                        }
                        .contentShape(Rectangle())
                        
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
            .sheet(isPresented: $goToSignup) {
                SignupPage()
            }
            .sheet(isPresented: $goToResetPassword) {
                ResetPassword()
            }
        }
    }
    
    private func checkInfos() {
        if email != "" && password != "" {
            if email.isValidEmail() {
                if password.count > 5 {
                    viewModel.signInUser(email: email, password: password) { AuthResult in
                        
                        switch AuthResult {
                        case .success(let auth):
                            viewModel.getUserInfos(id: auth.user.uid) { result in
                                switch result {
                                case .success(let user):
                                    globalClass.User = user
                                    self.user = user
                                    isDontLogin = false
                                case .failure(let error):
                                    errorText = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        case .failure(let error):
                            errorText = error.localizedDescription
                            showAlert = true
                        }
//                        if text == "Giriş Başarılı" {
//                            
//                            isDontLogin = false
//                        } else {
//                            errorText = text
//                            showAlert = true
//                        }
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
//    LoginPage()
//}
