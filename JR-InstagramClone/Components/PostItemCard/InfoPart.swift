//
//  InfoPart.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI

struct InfoPart: View {
    
    let width: CGFloat
    
    var body: some View {
         HStack {
             VStack(alignment: .leading) {
                 Button {
                     
                 } label: {
                     Text("20.334 beğenme")
                         .foregroundStyle(.primary)
                 }
                 
                 Button {
                     
                 } label: {
                     Text("kendi yorumu")
                         .foregroundStyle(.primary)
                 }
                 
                 Button {
                     
                 } label: {
                      Text("165 yorumun tümünü gör")
                         .foregroundStyle(.secondary)
                 }
                 
                 Text("1 Temmuz")
                     .foregroundStyle(.secondary)
                 
             }
             Spacer()
         }
         .frame(width: width)
    }
}
