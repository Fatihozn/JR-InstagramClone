////
////  PhotoPicker.swift
////  JR-InstagramClone
////
////  Created by Fatih Özen on 31.07.2024.
////
//
//import SwiftUI
//import UIKit
//
//enum ImagePickerType {
//    case profile
//    case post
//    case story
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//   // @Binding var isUploaded: Bool
//    @Binding var Loading: Bool
//    @Binding var selectedTab: Int
//    var pickerType: ImagePickerType
//    @Environment(\.presentationMode) var presentationMode
//    var sourceType: UIImagePickerController.SourceType
//    
//    @ObservedObject private var viewModel = ProfileEditViewModel()
//    @EnvironmentObject var globalClass: GlobalClass
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//        
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            var image: UIImage?
//            
//            if let editedImage = info[.editedImage] as? UIImage {
//                image = editedImage
//            } else if let originalImage = info[.originalImage] as? UIImage {
//                image = originalImage
//            }
//            
//            if let image {
//                switch parent.pickerType {
//                case .profile:
//                    profileImagePicker(image: image)
//                case .post:
////                    parent.selectedTab = 0
//                    postImagePicker(image: image)
//                case .story:
//                    storyImagePicker(image: image)
//                }
//            }
//            
//        }
//        
//        private func profileImagePicker(image: UIImage) {
//            if let user = parent.globalClass.User {
//                parent.Loading = true
//                if user.profilePhoto != nil {
//                    print("silinen foto:  \(user.profilePhoto?.id ?? "")")
//                    parent.viewModel.deleteImage(imagePath: user.profilePhoto?.id ?? "") { isDeleted in
//                        print("silindi: \(isDeleted)")
//                    }
//                }
//                
//                parent.viewModel.uploadProfileImage(id: user.id ?? "", image: image) { [weak self] message in
//                    guard let self else { return }
//                    if message == "Yükleme Başarılı" {
//                        parent.viewModel.getUserInfos(id: user.id ?? "") { [weak self] result in
//                            guard let self else { return }
//                            switch result {
//                            case .success(let user):
//                                parent.globalClass.User = user
//                             //   parent.isUploaded = true
//                                parent.Loading = false
//                                self.parent.presentationMode.wrappedValue.dismiss()
//                            case .failure(let error):
//                                print(error.localizedDescription)
//                            }
//                        }
//                    }
//                }
//                
//            }
//        }
//        
//        private func postImagePicker(image: UIImage) {
//            if let user = parent.globalClass.User {
//                parent.Loading = true
//                
//                parent.viewModel.uploadPostImage(id: user.id ?? "", image: image, oldPostIDs: user.postIDs) { [weak self] message in
//                    guard let self else { return }
//                    if message == "Yükleme Başarılı" {
//                        parent.viewModel.getUserInfos(id: user.id ?? "") { [weak self] result in
//                            guard let self else { return }
//                            switch result {
//                            case .success(let user):
//                                parent.globalClass.User = user
//                                parent.Loading = false
//                                self.parent.presentationMode.wrappedValue.dismiss()
//                                parent.selectedTab = 0
//                            case .failure(let error):
//                                print(error.localizedDescription)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        private func storyImagePicker(image: UIImage) {
//            
//        }
//        
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            switch parent.pickerType {
//            case .profile:
//                parent.presentationMode.wrappedValue.dismiss()
//            case .post:
//                parent.selectedTab = 0
//            case .story:
//                parent.presentationMode.wrappedValue.dismiss()
//            }
//            
//        }
//        
//        
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = sourceType
//        picker.allowsEditing = true
//        picker.setEditing(true, animated: true)
//        
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//    
//    static func dismantleUIViewController(_ uiViewController: UIImagePickerController, coordinator: Coordinator) {
//        uiViewController.dismiss(animated: true, completion: nil)
//    }
//}
