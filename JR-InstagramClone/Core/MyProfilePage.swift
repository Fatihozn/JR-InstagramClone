//
//  ProfileView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct MyProfilePage: View {
    
    @Binding var isDontLogin: Bool
    
    @State private var selectedSegment = 0
    let segments = ["squareshape.split.3x3", "play.square.stack", "person.crop.square"]
    
    @State private var user: User?
    @EnvironmentObject var globalClass: GlobalClass
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                if let user {
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: width / 10) {
                                MyStoryItemCard(size: width / 4)
                                ProfileNumber_text(number: 7, text: "gönderi")
                                ProfileNumber_text(number: user.followers, text: "takipçi")
                                ProfileNumber_text(number: user.following, text: "takip")
                                
                            }
                            if user.name_Lname != "" {
                                Text(user.name_Lname)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                    .padding(.top, 2)
                            }
                            if user.biography != "" {
                                Text(user.biography)
                            }
                            if user.titles != ""{
                                Text(user.titles)
                                    .padding(.bottom, 5)
                            }
                            
                            HStack(alignment: .center) {
                                Spacer()
                                
                                NavigationLink {
                                    ProfileEditPage()
                                } label: {
                                    Text("Düzenle")
                                        .ProfileButtonStyle(size: width / 2.3, color: Color.secondary.opacity(0.5))
                                        .contentShape(Rectangle())
                                }
                                
                                
                                Button {
                                    
                                } label: {
                                    Text("Profili paylaş")
                                        .ProfileButtonStyle(size: width / 2.3, color: Color.secondary.opacity(0.5))
                                        .contentShape(Rectangle())
                                }
                                
                                
                                Spacer()
                            }
                            
                        }
                        
                        Section {
                            LazyVGrid(columns: [
                                GridItem(.flexible(minimum: width / 3.1, maximum: width / 3)),
                                GridItem(.flexible(minimum: width / 3.1, maximum: width / 3)),
                                GridItem(.flexible(minimum: width / 3.1, maximum: width / 3))]) {
                                    
                                    ForEach(0...20, id: \.self) { _ in
                                        Image(systemName: "house")
                                            .resizable()
                                            .scaledToFit()
                                            .background(.gray)
                                    }
                                }
                        } header: {
                            
                            Picker("", selection: $selectedSegment) {
                                ForEach(0 ..< segments.count){ i in
                                    Image(systemName: segments[i]).tag(i)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.top)
                            
                        }
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                
                            } label: {
                                HStack {
                                    Text(user.username)
                                        .font(.title2)
                                    Image(systemName: "chevron.down")
                                    
                                }
                            }
                        }
                        
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "plus.app")
                            }
                            
                            NavigationLink {
                                ProfileSettings(isDontLogin: $isDontLogin)
                            } label: {
                                Image(systemName: "text.justify")
                            }
                        }
                    }
                    .tint(.white)
                    
                }
                
                
            }
            .onAppear {
                if let user = globalClass.User {
                    self.user = user
                }
            }
        }
        
    }
}

//#Preview {
//    MyProfilePage(isDontLogin: .constant(false))
//}
