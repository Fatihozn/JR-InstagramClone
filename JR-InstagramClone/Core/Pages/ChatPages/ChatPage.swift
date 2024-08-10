//
//  ChatPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 8.08.2024.
//

import SwiftUI
import Kingfisher

struct ChatPage: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ChatViewModel()
    @EnvironmentObject var globalClass: GlobalClass
    
    var chat: Chat
    
    @State var text = ""
    @State var isEditing = false
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            //let height = geo.size.height
            
            ScrollViewReader { scrollProxy in
                VStack {
                    
                    // MARK: - Header
                    
                    HStack {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 10, height: 20)
                                .padding(.horizontal)
                        }
                        KFImage(URL(string: chat.user?.profilePhoto?.photoUrl ?? ""))
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                        
                        Text(chat.user?.username ?? "")
                            .font(.system(size: 22, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    .background(Color(hex: "#333333"))
                    
                    // MARK: - Content
                    
                    ScrollView {
                        
                        ForEach(viewModel.Messages, id: \.self) { message in
                            ChatBubbleView(message: message, isCurrentUser: message.userId.elementsEqual(globalClass.User?.id ?? ""))
                        }
                    }
                    
                    // MARK: - Footer
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(width: 20, height: 20)
                                .padding(.leading, 15)
                                .padding(.trailing, 5)
                        }
                        
                        
                        ChatTextEditor(text: $text, width: width / 1.6, height: 40)
                        
                        if isEditing {
                            
                            Button {
                                viewModel.updateChat(userId: globalClass.User?.id ?? "", chatId: chat.id ?? "", message: text)
                                text = ""
                                hideKeyboard()
                            } label: {
                                Image("chatSend")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.black)
                                    .padding(8)
                                    .background(.green.opacity(0.8))
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                            .padding(.trailing, 10)
                            .contentShape(Circle())
                            
                        } else {
                            Button {
                                
                            } label: {
                                Image(systemName: "camera")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                                    .frame(width: 25, height: 20)
                                    .padding(.horizontal, 15)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "mic")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 25)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    .frame(width: width)
                    .background(Color(hex: "#333333"))
                    
                }
                .navigationBarBackButtonHidden()
                .onDisappear {
                    viewModel.closeListener()
                }
                .onAppear {
                    viewModel.getChat(chatId: chat.id ?? "")
                    scrollProxy.scrollTo(viewModel.Messages.last, anchor: .bottom)
                    viewModel.listenForMessages(chatID: chat.id ?? "")
                }
                .onChange(of: text) {
                    withAnimation {
                        if text != "" {
                            isEditing = true
                        } else {
                            isEditing = false
                        }
                    }
                }
                
            }
            .tint(.white)
            
        }
    }
}

