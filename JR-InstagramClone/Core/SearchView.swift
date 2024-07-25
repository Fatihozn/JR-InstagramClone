//
//  SearchView.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 20.07.2024.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @State var searchBarTapped = false
    @State var showCancel = false
    
    var dict: [Int: [String]] = [
        1: ["house","house","house","house","house","house","house","house","house","house"],
        2: ["house.fill","house.fill","house.fill","house.fill","house.fill","house.fill","house.fill","house.fill","house.fill","house.fill"]
    ]
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                
                Group {
                    if searchBarTapped {
                        
                        List {
                            ForEach(0...10, id: \.self) { _ in
                                Text("Text")
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                    } else {
                        ScrollView(showsIndicators: false) {
                            
                            ForEach(dict.keys.sorted(), id: \.self) { key in
                                GridView(width: width, arr: dict[key]!)
                            }
                            
                        }
                        .padding(.top, 5)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        SearchBar(text: $searchText, isTapped: $searchBarTapped, showCancel: $showCancel)
                            .frame(width: width / 1.1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    SearchView()
}

