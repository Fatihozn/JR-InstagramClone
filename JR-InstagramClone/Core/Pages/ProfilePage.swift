//
//  ProfilePage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI

struct ProfilePage: View {
    
    @State private var selectedSegment = 0
    let segments = ["squareshape.split.3x3", "play.square.stack", "person.crop.square"]
    
    @State var isFollowing = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                
                ZStack {
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: width / 10) {
                                StoryItemCard(size: width / 4,isShowStory: true, isProfilePageActive: .constant(false))
                                ProfileNumber_text(number: 7, text: "gönderi")
                                ProfileNumber_text(number: 542, text: "takipçi")
                                ProfileNumber_text(number: 507, text: "takip")
                                
                            }
                            
                            Text("Fatih Özen")
                            Text("KOU | CENG")
                            
                            HStack(alignment: .center) {
                                Spacer()
                                Group {
                                    if isFollowing {
                                        Button {
                                            
                                        } label: {
                                            HStack {
                                                Text("Takiptesin")
                                                Image(systemName: "chevron.down")
                                                    .font(.system(size: 14))
                                            }
                                            .ProfileButtonStyle(size: width / 2.4, color: Color.secondary.opacity(0.5))
                                        }
                                        
                                    } else {
                                        Button {
                                            isFollowing = true
                                        } label: {
                                            Text("Takip Et")
                                        }
                                        .ProfileButtonStyle(size: width / 2.4, color: Color.blue)
                                        
                                    }
                                    
                                }
                                
                                
                                Button {
                                    
                                } label: {
                                    Text("Mesaj")
                                }
                                .ProfileButtonStyle(size: width / 2.4, color: Color.secondary.opacity(0.5))
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "person.badge.plus")
                                }
                                .padding(5)
                                .background(Color.secondary.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                
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
                    
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Geri git
                        }) {
                            Image(systemName: "chevron.left") // Geri butonu simgesi
                        }
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        
                        if isFollowing {
                            Button {
                                
                            } label: {
                                Image(systemName: "bell")
                            }
                        }
                        
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
                .tint(.white)
                .navigationTitle("Kullanıcı Adı")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                
            }
        }
        
    }
}

#Preview {
    ProfilePage()
}
