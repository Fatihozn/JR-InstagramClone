//
//  ProfileSettings.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 24.07.2024.
//

import SwiftUI

struct ProfileSettings: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchText: String = ""
    
    var items: [(title: String, arr: [(text: String, image: String)])] = [
        ("Instagram'ı nasıl kullanıyorsun?", [
            ("Kaydedildi", "bookmark"),
            ("Arşiv", "clock.arrow.circlepath"),
            ("Hareketlerin", "doc.text.below.ecg"),
            ("Bildirimler", "bell"),
            ("Geçirilen süre", "clock")
        ]),
        ("İçeriklerini kimler görebilir?", [
            ("Hesap gizliliği", "lock"),
            ("Yakın Arkadaşlar", "star.circle"),
            ("Engellenenler", "slash.circle"),
            ("Hikayeyi ve canlı videoları gizle", "circle.slash")
        ]),
        ("Başkalarının seninle etkileşimleri", [
            ("Mesajlar ve hikaye yanıtları", "ellipsis.message"),
            ("Etiketler ve bahsetmeler", "person.crop.square.filled.and.at.rectangle"),
            ("Yorumlar", "message"),
            ("Paylaşım", "arrow.2.squarepath"),
            ("Kısıtlılar", "person.slash"),
            ("Etkileşimleri sınırla", "exclamationmark.bubble"),
            ("Gizlenen Sözcükler", "character.book.closed"),
            ("Arkadaşları takip et ve davet et", "person.badge.plus")
        ]),
        ("Neler görüyorsun?", [
            ("Favoriler", "star"),
            ("Sessize alınan hesaplar", "bell.slash"),
            ("Önerilen içerikler", "photo.on.rectangle.angled"),
            ("Beğenme ve paylaşım sayıları", "heart.slash")
        ]),
        ("Uygulaman ve medya", [
            ("Cihaz izinleri", "iphone"),
            ("Arşivleme ve indirme", "arrow.down.to.line"),
            ("Erişilebilirlik ve çeviriler", "accessibility"),
            ("Dil", "message.badge.waveform"),
            ("Veri kullanımı ve medya kalitesi", "cellularbars"),
            ("İnternet sitesi izinleri", "macbook.and.iphone")
        ]),
        ("Aileler için", [
            ("Gözetim", "person.2")
        ]),
        ("Profesyoneller için", [
            ("Hesap türü ve araçları", "square.split.2x2"),
            ("Profilinin doğrulandığını göster", "checkmark.seal")
        ]),
        ("Siparişlerin ve bağış kampanyaların", [
            ("Siparişler ve ödemeler", "menubar.dock.rectangle")
        ]),
        ("Daha fazla bilgi ve destek", [
            ("Yardım", "questionmark.app"),
            ("Hesap Durumu", "person"),
            ("Hakkında", "info.circle")
        ])
    ]
    
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            List {
                VStack(alignment: .leading) {
                    Text("Hesabın")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 10)
                    
                    NavigationLink {
                        
                    } label: {
                        HStack(alignment: .center) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: width / 14, height: width / 14)
                                .padding(.trailing, 5)
                                .padding(.bottom, 15)
                            VStack(alignment: .leading) {
                                Text("Hesaplar Merkezi")
                                    .foregroundStyle(.primary)
                                Text("Şifre, güvenlik, kişisel detaylar, reklam tercihleri")
                                    .foregroundStyle(.secondary)
                            }
                            
                        }
                        
                    }
                    
                }
                .frame(width: width)
                .listRowSeparator(.hidden)
                
                ForEach(items, id: \.title) { item in
                    VStack(spacing: 0){
                        VStack(alignment: .leading, spacing: 20){
                            Divider()
                                .frame(width: width, height: 6)
                                .background(.gray.opacity(0.2))
                            Text(item.title)
                                .foregroundStyle(.secondary)
                                .padding(.bottom, 10)
                                
                        }
                        
                        ForEach(item.arr, id: \.text){ item in
                           
                            ProfileSettingsListItem(txt: item.text, img: item.image)
                                .font(.title3)
                                .padding(.vertical, 8)

                        }
                        
                    }
                    .listRowSeparator(.hidden)
                    
                }
                
                VStack(alignment: .leading) {
                    Divider()
                        .frame(width: width, height: 6)
                        .background(.gray.opacity(0.2))
                    Text("Giriş yap")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 10)
                    
                    Button {
                        
                    } label: {
                        
                        Text("Hesap ekle")
                            .foregroundStyle(.blue)
                        
                    }
                    .padding(.bottom)
                    
                    Button {
                        
                    } label: {
                        
                        Text("Çıkış yap")
                            .foregroundStyle(.red)
                        
                    }
                }
                .listRowSeparator(.hidden)
                
            }
            
        }
        .searchable(text: $searchText)
        .listStyle(.plain)
        .navigationBarTitle("Ayarlar ve hareketler", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // Varsayılan geri butonunu gizle
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Geri git
                }) {
                    Image(systemName: "chevron.left") // Geri butonu simgesi
                }
            }
        }
    }
}

#Preview {
    ProfileSettings()
}
