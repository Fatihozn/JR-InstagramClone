//
//  PhotoPicker.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 31.07.2024.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isUploaded: Bool
    @Binding var Loading: Bool
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType
    
    @ObservedObject private var viewModel = ProfileEditViewModel()
    @EnvironmentObject var globalClass: GlobalClass
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var image: UIImage?
            
            if let editedImage = info[.editedImage] as? UIImage {
                image = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                image = originalImage
            }
            
            if let user = parent.globalClass.User {
                parent.Loading = true
                if user.profilePhoto != "" {
                    print("silinen foto:  \(user.profilePhoto)")
                    parent.viewModel.deleteImage(imagePath: user.profilePhoto) { isDeleted in
                        print("silindi: \(isDeleted)")
                    }
                }
                if let image {
                    parent.viewModel.uploadImage(id: user.id ?? "", image: image) { [weak self] message in
                        guard let self else { return }
                        print("edit Page:\(message)")
                        if message == "Yükleme Başarılı" {
                            parent.viewModel.getUserInfos(id: user.id ?? "") { [weak self] result in
                                guard let self else { return }
                                switch result {
                                case .success(let user):
                                    parent.globalClass.User = user
                                    parent.isUploaded = true
                                    parent.Loading = false
                                    self.parent.presentationMode.wrappedValue.dismiss()
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.setEditing(true, animated: true)
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    static func dismantleUIViewController(_ uiViewController: UIImagePickerController, coordinator: Coordinator) {
        uiViewController.dismiss(animated: true, completion: nil)
    }
}
