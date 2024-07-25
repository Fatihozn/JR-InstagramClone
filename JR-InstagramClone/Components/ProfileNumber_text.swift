//
//  ProfileNumber_text.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 25.07.2024.
//

import SwiftUI

struct ProfileNumber_text: View {
    
    var number: Int
    var text: String
    
    var body: some View {
        VStack {
            Text(String(number))
                .foregroundStyle(.primary)
            Text(text)
                .foregroundStyle(.secondary)
        }
    }
}
