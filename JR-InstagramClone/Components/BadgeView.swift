//
//  BadgeView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 21.07.2024.
//

import SwiftUI

struct BadgeView: View {
    let count: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 20, height: 20)
            Text("\(count)")
                .foregroundColor(.white)
                .font(.system(size: 12))
                .bold()
        }
    }
}
