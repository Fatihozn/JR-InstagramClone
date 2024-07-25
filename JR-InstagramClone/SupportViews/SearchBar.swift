//
//  SearchBar.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 24.07.2024.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var isTapped: Bool
    @Binding var showCancel: Bool
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isTapped: Bool
        @Binding var showCancel: Bool
        
        init(text: Binding<String>, isTapped: Binding<Bool>, showCancel: Binding<Bool>) {
            _text = text
            _isTapped = isTapped
            _showCancel = showCancel
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            withAnimation {
                isTapped = true
                showCancel = true
            }
            
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            withAnimation {
                isTapped = false
                showCancel = false
                text = ""
            }
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isTapped: $isTapped, showCancel: $showCancel)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = showCancel
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

