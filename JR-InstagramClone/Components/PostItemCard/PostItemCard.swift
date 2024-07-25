//
//  PostItemCard.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI

struct PostItemCard: View {
    
    let width: CGFloat
    
    var body: some View {
        VStack {
          
            ImagePart(width: width)
            ActionsPart()
            InfoPart(width: width)
          
        }
    }
}

