//
//  MyStoryItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI
import Kingfisher

struct MyStoryItemCard: View {
    
    let size: CGFloat
    var text: String = ""
    
    @State var goToStory = false
    @State var goToImagePicker = false
    @State var Loading = false
    
    @EnvironmentObject var globalclass: GlobalClass
    
    var body: some View {
        if let user = globalclass.User {
            Button {
                clickStory(user: user)
            } label: {
                VStack {
                    Group {
                        if let photoUrl = user.profilePhoto?.photoUrl {
                            KFImage(URL(string: photoUrl))
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay(
                        ((user.stories?.filter { $0.timestamp.hourDiffrence() != "eski" }.isEmpty) ?? true) ? AnyView(EmptyView()) :
                            AnyView(
                                Circle().stroke(
                                    LinearGradient(
                                        gradient:
                                            user.stories?
                                            .filter { $0.timestamp.hourDiffrence() != "eski" }
                                            .compactMap { $0.seenBy?.contains(user.id ?? "") ?? false ? true : nil } == [] ?
                                        Gradient(colors: [
                                            Color(hex: "#405DE6"),
                                            Color(hex: "#833AB4"),
                                            Color(hex: "#C13584"),
                                            Color(hex: "#F77737"),
                                            Color(hex: "#FCAF45")]) :
                                            Gradient(colors: [.gray]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading
                                    ),
                                    lineWidth: 4
                                )
                            )
                    )
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(.black, lineWidth: 8)
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                            Text("+")
                                .foregroundColor(.white)
                                .font(.system(size: 26))
                                .bold()
                        }
                            .offset(x: 35, y: 35)
                    )
                    if text != "" {
                        Text(text)
                    }
                    
                }
                
            }
            .fullScreenCover(isPresented: $goToImagePicker) {
                ZStack {
                    YPImagePickerView(Loading: $Loading, selectedTab: .constant(0), pickerType: .story)
                    
                    if Loading {
                        VStack {
                            ProgressView()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        }
                        .background(.black.opacity(0.5))
                    }
                }
            }
            .fullScreenCover(isPresented: $goToStory) {
                StoryPage(user: user)
            }
            
        }
        else {
            VStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay(EmptyView())
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(.black, lineWidth: 8)
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                            Text("+")
                                .foregroundColor(.white)
                                .font(.system(size: 26))
                                .bold()
                        }
                            .offset(x: 35, y: 35)
                    )
                if text != "" {
                    Text(text)
                }
            }
        }
        
    }
    
    
    private func clickStory(user: User?) {
        if !(user?.stories?.filter { $0.timestamp.hourDiffrence() != "eski" }.isEmpty ?? true) {
            goToStory = true
        } else {
            goToImagePicker = true
        }
        
    }
    
}
