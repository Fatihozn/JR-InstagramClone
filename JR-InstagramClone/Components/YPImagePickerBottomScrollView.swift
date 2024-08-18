//
//  YPImagePickerBottomScrollView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 15.08.2024.
//

import SwiftUI

struct YPImagePickerBottomScrollView: View {
    @Binding var selectedIndex: Int
    var sections = ["Gönderi", "Hikaye", "Reels Videosu"]
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let horizontalPadding = size.width / 2.3
            
            VStack {
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sections.indices, id: \.self) { index in
                            
                            Text(sections[index])
                                .font(.system(size: 18, weight: .bold))
                                .padding(.horizontal, 10)
                                .foregroundStyle(index == selectedIndex ? .white : .secondary)
                                .contentShape(Rectangle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .background(RoundedRectangle(cornerRadius: 45)
                        .fill(Color(hex: "#363636").opacity(0.95))
                    )
                    .scrollTargetLayout()
                }
                .padding(.bottom, 5)
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: .init(get: {
                    let position: Int? = selectedIndex
                    return position
                }, set: { newValue in
                    if let newValue {
                        withAnimation {
                            selectedIndex = newValue
                        }
                    }
                }))
                .safeAreaPadding(.horizontal ,horizontalPadding)
            }
            
            
            
        }
        
    }
}
//
//#Preview {
//    YPImagePickerBottomScrollView()
//}
