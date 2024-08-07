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
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            ZStack {
                ImagePicker(Loading: $Loading, selectedTab: $selectedTab, pickerType: .post, sourceType: .photoLibrary)
                
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
