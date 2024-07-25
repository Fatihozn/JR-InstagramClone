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
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: width / 10) {
                            MyStoryItemCard(size: width / 4)
                            ProfileNumber_text(number: 7, text: "gönderi")
                            ProfileNumber_text(number: 542, text: "takipçi")
                            ProfileNumber_text(number: 507, text: "takip")
                            
                        }
                        
                        Text("Fatih Özen")
                        Text("KOU | CENG")
                        
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Düzenle")
                            }
                            .padding(.vertical, 6)
                            .foregroundStyle(.white)
                            .frame(width: width / 2.3)
                            .background(Color.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Button {
                                
                            } label: {
                                Text("Profili paylaş")
                            }
                            .padding(.vertical, 6)
                            .foregroundStyle(.white)
                            .frame(width: width / 2.3)
                            .background(Color.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
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
                                Text("Kullanıcı Adı")
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
                            ProfileSettings()
                        } label: {
                            Image(systemName: "text.justify")
                        }
                    }
                }
                .tint(.white)
                
            }
        }
        
    }
}

#Preview {
    ProfilePage()
}
