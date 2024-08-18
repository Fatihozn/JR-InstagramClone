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
                    VStack(alignment: .leading) {
                        Text(chat.user?.name_Lname ?? "")
                            .font(.system(size: 20, weight: .bold))
                            .lineLimit(1)
                        
                        Text(chat.user?.username ?? "")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                   
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "phone")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                            .frame(width: 25, height: 25)
                            .padding(.horizontal, 10)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "video")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 25)
                            .padding(.horizontal, 5)
                    }
                }
                .padding(.bottom, 10)
                .background(.clear) // Color(hex: "#333333")
                
                // MARK: - Content
                
                ScrollView {
                    ScrollViewReader { scrollProxy in
                        
                        ForEach(viewModel.Messages.indices, id: \.self) { index in
                            ChatBubbleView(message: viewModel.Messages[index], isCurrentUser: viewModel.Messages[index].userId.elementsEqual(globalClass.User?.id ?? ""))
                                .id(index)
                        }
                        .onChange(of: viewModel.Messages) {
                            withAnimation {
                                scrollProxy.scrollTo(viewModel.Messages.count - 1, anchor: .bottom)
                            }
                        }
                        
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                
                // MARK: - Footer
                
                HStack {
                    if isEditing {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color(hex: "#7a67ee"))
                                .fontWeight(.bold)
                                .frame(width: 20, height: 20)
                                .padding(.leading, 10)
                        }
                        
                    } else {
                        Button {
                            
                        } label: {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(Color(hex: "#7a67ee"))
                                .frame(width: 43, height: 38)
                                .clipShape(Circle())
                                .padding(.leading, 5)
                        }
                    }
                   
                    ChatTextEditor(text: $text, width: width / 1.6, height: 40)
                    
                    if isEditing {
                        Button {
                            viewModel.updateChat(userId: globalClass.User?.id ?? "", chatId: chat.id ?? "", message: text)
                            text = ""
                        } label: {
                            Image("chatSend")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Color(hex: "#7a67ee"))
                                .frame(width: 38, height: 38)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(-40))
                        }
                        .padding(.trailing, 10)
                        .contentShape(Circle())
                        
                    } else {
                        Button {
                            
                        } label: {
                            Image(systemName: "mic")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(width: 20, height: 25)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "photo")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 25)
                                .padding(.horizontal, 8)
                        }
                        
                        Button {
                            
                        } label: {
                            Image("sticker")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 20)
                        }
                    }
                        
                    
                }
                .padding(.vertical, 5)
                .frame(width: width)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill( Color(hex: "#333333"))
                )
                .padding(.bottom, 5)
                
               // MARK: -
                
            }
            .tint(.white)
            .navigationBarBackButtonHidden()
            .onDisappear {
                viewModel.closeListener()
            }
            .onAppear {
                viewModel.getChat(chatId: chat.id ?? "")
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
    }
}

//#Preview {
//    chatPageFooter(width: UIScreen.main.bounds.width, isEditing: .constant(true))
//}

//struct chatPageFooter: View {
//    
//    @State var text = ""
//    var width: CGFloat
//    @Binding var isEditing: Bool
//    
//    @ObservedObject var viewModel = ChatViewModel()
//    @EnvironmentObject var globalClass: GlobalClass
//    //var chat: Chat
//    
//    var body: some View {
//        HStack {
//            if isEditing {
//                Button {
//                    
//                } label: {
//                    Image(systemName: "magnifyingglass")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(Color(hex: "#7a67ee"))
//                        .fontWeight(.bold)
//                        .frame(width: 20, height: 20)
//                        .padding(.leading, 10)
//                }
//                
//            } else {
//                Button {
//                    
//                } label: {
//                    Image(systemName: "camera.fill")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(.white)
//                        .padding(10)
//                        .background(Color(hex: "#7a67ee"))
//                        .frame(width: 43, height: 38)
//                        .clipShape(Circle())
//                }
//            }
//           
//            ChatTextEditor(text: $text, width: width / 1.6, height: 40)
//            
//            if isEditing {
//                
//                Button {
////                    viewModel.updateChat(userId: globalClass.User?.id ?? "", chatId: chat.id ?? "", message: text)
//                    text = ""
//                    hideKeyboard()
//                } label: {
//                    Image("chatSend")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(.white)
//                        .padding(8)
//                        .background(Color(hex: "#7a67ee"))
//                        .frame(width: 38, height: 38)
//                        .clipShape(Circle())
//                }
//                .padding(.trailing, 10)
//                .contentShape(Rectangle())
//                
//            } else {
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "mic")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(.white)
//                        .frame(width: 20, height: 25)
//                }
//                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "photo")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(.white)
//                        .frame(width: 25, height: 25)
//                        .padding(.horizontal, 8)
//                }
//                
//                Button {
//                    
//                } label: {
//                    Image("sticker")
//                        .resizable()
//                        .renderingMode(.template)
//                        .foregroundStyle(.white)
//                        .frame(width: 25, height: 25)
//                        .padding(.trailing, 20)
//                }
//                
//            }
//                
//            
//        }
//        .padding(.vertical, 5)
//        .frame(width: width)
//        .background(
//            RoundedRectangle(cornerRadius: 25)
//                .fill( Color(hex: "#333333"))
//        )
//    }
//}
