//
//  ActionsPart.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI

struct ActionsPart: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30) // İstediğiniz boyutlara ayarlayın
                    .aspectRatio(contentMode: .fit)
                    .padding(3)
            }
            
            Button {
                
            } label: {
                Image("postChat")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 36, height: 36)
                    .aspectRatio(contentMode: .fill)
                    .padding(3)
                   
            }
            
            Button {
                
            } label: {
                Image("send")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30) // İstediğiniz boyutlara ayarlayın
                    .aspectRatio(contentMode: .fit)
                    .padding(3)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bookmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 30) // İstediğiniz boyutlara ayarlayın
                    .aspectRatio(contentMode: .fit)
                    .padding(3)
            }
        }
    }
}

#Preview {
    ActionsPart()
}
