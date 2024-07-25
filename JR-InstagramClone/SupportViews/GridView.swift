//
//  FriendsView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 24.07.2024.
//

import SwiftUI

struct GridView: View {
    
    let width: CGFloat
    let arr: [String]
    
    var body: some View {
        Grid(alignment: .top) {
            
            GridRow {
                
                GridCustomItem(image: arr[0], width: width)
                GridCustomItem(image: arr[1], width: width)
                
                Image(systemName: arr[2])
                    .resizable()
                    .scaledToFill()
                    .background(.red)
                    .frame(width: width / 3.1, height: width / 1.5)
                    .clipped()
                
            }
            
            GridRow {
                GridCustomItem(image: arr[3], width: width)
                GridCustomItem(image: arr[4], width: width)
            }
            .padding(.top, -1 * (width / 2.9))
            
            GridRow {
                Image(systemName: arr[5])
                    .resizable()
                    .scaledToFill()
                    .background(.red)
                    .frame(width: width / 3.1, height: width / 1.5)
                    .clipped()
                
                GridCustomItem(image: arr[6], width: width)
                GridCustomItem(image: arr[7], width: width)
                
            }
            .padding(.top, -8)
            
            GridRow {
                Spacer()
                
                GridCustomItem(image: arr[8], width: width)
                GridCustomItem(image: arr[9], width: width)
                
            }
            .padding(.top, -1 * (width / 2.9))
            
        }
    }
}

struct GridCustomItem: View {
    
    var image: String
    var width: CGFloat
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFill()
            .background(.gray)
            .frame(width: width / 3.1, height: width / 3.1)
            .clipped()
    }
}
