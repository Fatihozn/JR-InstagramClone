//
//  ProfileEditPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import SwiftUI

struct ProfileEditPage: View {
    
    @EnvironmentObject var globalClass: GlobalClass
//    @Environment(\.dismiss) var dismiss
    
    @State var arr: [(title: String, value: String, dataName: String)] = []
   
    
    var body: some View {
            
            GeometryReader { geo in
                let width = geo.size.width
                List {
                    Button {
                        print("Resmi Düzenle")
                    } label: {
                        VStack(alignment: .center) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: width / 4, height: width / 4)
                                .clipShape(Circle())
                                .foregroundStyle(.white)
                                .padding(10)
                            
                            Text("Resmi Düzenle")
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                        }
                        .contentShape(Rectangle())
                        .frame(width: width)
                    }
                    
                    ForEach($arr, id: \.title) { $item in
                        NavigationLink {
                            TextFieldEditingView(id: globalClass.User?.id ?? "" ,item: $item)
                        } label: {
                            HStack {
                                Text(item.title)
                                    .font(.system(size: 16))
                                    .frame(width: width / 5, alignment: .leading)
                                
                                VStack(alignment: .leading) {
                                    Text(item.value == "" ? item.title : item.value)
                                        .font(.system(size: 16))
                                        .foregroundStyle(item.value == "" ? .secondary : .primary)
                                    
                                    CustomListRowSeparator()
                                }
                                
                            }
                            .foregroundStyle(.white)
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                    }
                    
                }
                .onAppear {
                    if let user = globalClass.User {
                        arr.removeAll()
                        
                        let temp =  [
                            ("Adı", user.name_Lname, "name_Lname"),
                            ("Kullanıcı adı", user.username, "username"),
                            ("Hitaplar", user.titles, "titles"),
                            ("Biyografi", user.biography, "biography"),
                            ("Cinsiyet", user.gender, "gender")]
                        
                        arr.append(contentsOf: temp)
                    }
                    
                }
                .listStyle(.plain)
                .navigationTitle("Profili düzenle")
                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button(action: {
//                            dismiss() // Geri git
//                        }) {
//                            Image(systemName: "chevron.left") // Geri butonu simgesi
//                        }
//                    }
//                }
            
            
        }
        
    }
}

//#Preview {
//    ProfileEditPage()
//}

struct CustomListRowSeparator: View {
    var body: some View {
        Rectangle()
            .frame(height: 0.5) // Ayırıcı yüksekliği
            .foregroundColor(.gray) // Ayırıcı rengi
        //  .padding(.horizontal) // Yatay dolgu
    }
}
