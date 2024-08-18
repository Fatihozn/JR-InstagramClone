//
//  NewPost.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct NewPostPage: View {
    
    @State var Loading = false
    
    @Binding var selectedTab: Int
    @State var selectedIndex: Int = 0
    @State var didSelectedNext = false
    
    @State var pickers: [ImagePickerType] = [.post, .story, .reels]
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            ZStack {
                switch selectedIndex {
                case 0:
                    YPImagePickerView(Loading: $Loading, selectedTab: $selectedTab, isRootPostPage: true, pickerType: .post)
                case 1:
                    YPImagePickerView(Loading: $Loading, selectedTab: $selectedTab, isRootPostPage: true, pickerType: .story)
                case 2:
                    YPImagePickerView(Loading: $Loading, selectedTab: $selectedTab, isRootPostPage: true, pickerType: .reels)
                default:
                    Text("HATA !")
                    
                }
               
                
                if !didSelectedNext {
                    YPImagePickerBottomScrollView(selectedIndex: $selectedIndex)
                }
                
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

//#Preview {
//    NewPost()
//}
