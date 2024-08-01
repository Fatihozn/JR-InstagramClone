//
//  ProfileEditPage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import SwiftUI
import Kingfisher

struct ProfileEditPage: View {
    
    @EnvironmentObject var globalClass: GlobalClass
    
    @State private var image: KFImage?
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    @State private var isUploaded = false
    @State private var Loading = false
    
    @State var arr: [(title: String, value: String, dataName: String)] = []
    
    @ObservedObject private var viewModel = ProfileEditViewModel()
    
    var body: some View {
        
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            List {
                Button {
                    showActionSheet = true
                } label: {
                    VStack(alignment: .center) {
                        if let image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: width / 4, height: width / 4)
                                .clipShape(Circle())
                                .foregroundStyle(.white)
                                .padding(10)
                            
                        } else if globalClass.User?.profilePhoto == "" {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: width / 4, height: width / 4)
                                .clipShape(Circle())
                                .foregroundStyle(.white)
                                .padding(10)
                            
                        } else {
                            ProgressView()
                                .frame(width: width / 4, height: width / 4)
                                .padding(10)
                        }
                        
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
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Fotoğraf Seç"), message: Text("Fotoğrafı nereden seçmek istersiniz ?"), buttons: [
                    .default(Text("Fotoğraflardan Seç")) {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    },
                    .default(Text("Kameradan Çek")) {
                        sourceType = .camera
                        showImagePicker = true
                    },
                    .cancel()
                ])
            }
            .onChange(of: isUploaded, {
                // profilePath değişkenine id atamaktansa url atamak daha mantıklı olabilir onu düşün ve buraya uygula sürekli firebase işlemi yapmak zorunda kalmaz
                if let user = globalClass.User {
                    print(user.profilePhoto)
                    if user.profilePhoto != "" {
                        viewModel.downloadImage(imagePath: user.profilePhoto) { image in
                            self.image = image
                        }
                    }
                }
            })
            .onAppear {
                if let user = globalClass.User {
                    arr.removeAll()
                    
                    // fotoğrafı storage dan çek
                    if user.profilePhoto != "" {
                        viewModel.downloadImage(imagePath: user.profilePhoto) { image in
                            self.image = image
                        }
                    }
                    
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
            .sheet(isPresented: $showImagePicker) {
                ZStack {
                    ImagePicker(isUploaded: $isUploaded, Loading: $Loading, sourceType: sourceType)
                    
                    if Loading {
                        VStack {
                            ProgressView()
                                .frame(width: width, height: height)
                        }
                        .background(.black.opacity(0.5))
                        
                    }
                }
                
            }
            
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
