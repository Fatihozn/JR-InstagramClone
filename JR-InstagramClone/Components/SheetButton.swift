//
//  SheetButton.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.08.2024.
//

import SwiftUI

struct SheetButton: View {
    var txt: String
    var img: String
    var imageIsRight = false
    var completion: () -> ()
    
    var body: some View {
        Button {
            completion()
        } label: {
            if img == "" {
                Text(txt)
                    .padding(5)
            } else {
                if imageIsRight {
                    HStack {
                        Text(txt)
                        Spacer()
                        Image(systemName: img)
                    }
                    .padding(5)
                } else {
                    Label(txt, systemImage: img)
                }
            }
           
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
    }
}
