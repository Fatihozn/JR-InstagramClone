//
//  TextFieldForEditing.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import SwiftUI

struct TextFieldEditingView: View {
    let id: String
    @Binding var item: (title: String, value: String, dataName: String)
    @Binding var isUpdated: Bool
    
    @State var showIndicator = false
    @State var showAlert = false
    @State var errorText = ""
    
    @ObservedObject private var viewModel = ProfileEditViewModel()
    
    @EnvironmentObject var globalClass: GlobalClass
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("\(item.title)", text: $item.value)
                .padding()
                .navigationTitle("\(item.title)")
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.white)
                }
                .padding(.horizontal)
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss() // Geri git
                }) {
                    Image(systemName: "chevron.left") // Geri butonu simgesi
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    updateInfos()
                    
                } label: {
                    if showIndicator {
                        ProgressView()
                    } else {
                        Text("Bitti")
                    }
                    
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            AlertFuncs.createOneButtonAlert(title: "Hata!", description: errorText)
        })
        
    }
    
    func updateInfos() {
        showIndicator = true
        
        viewModel.updateUserInfos(id: id, dataName: item.dataName, newValue: item.value) { message in
            showIndicator = false
            if message == "Güncellendi" {
                
                viewModel.getUserInfos(id: id) { result in
                    switch result {
                    case .success(let user):
                        globalClass.User = user
                        isUpdated.toggle()
                        dismiss()
                    case .failure(let error):
                        errorText = error.localizedDescription
                        showAlert = true
                    }
                }
                
                
            } else {
                errorText = message
                showAlert = true
            }
        }
    }
    
}

//#Preview {
//    TextFieldEditingView(id: .constant(""), item: .constant(("","","")))
//}
