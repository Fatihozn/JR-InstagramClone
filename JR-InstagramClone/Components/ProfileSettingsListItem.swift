//
//  ProfileSettingsListItem.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 24.07.2024.
//

import SwiftUI

struct ProfileSettingsListItem: View {
    
    var txt: String
    var img: String
    
    var body: some View {
        NavigationLink {
            
        } label: {
            HStack {
                Image(systemName: img)
                    .renderingMode(.template)
                Text(txt)
                    
            }
            .foregroundStyle(.primary)
        }
        
    }
}
