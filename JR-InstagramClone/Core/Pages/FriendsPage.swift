////
////  FriendsPage.swift
////  JR-InstagramClone
////
////  Created by Fatih Özen on 25.07.2024.
////
//
////import SwiftUI
//
//
////struct FriendsPage: View {
////    
////    var body: some View {
////        Text("Hello")
////    }
////}
//
//import SwiftUI
//import UIKit
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Binding var isPresented: Bool
//    @Environment(\.presentationMode) var presentationMode
//    var sourceType: UIImagePickerController.SourceType
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.isPresented = false
//            parent.presentationMode.wrappedValue.dismiss()
//        }
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
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    static func dismantleUIViewController(_ uiViewController: UIImagePickerController, coordinator: Coordinator) {
//        uiViewController.dismiss(animated: true, completion: nil)
//    }
//}
//
//import SwiftUI
//import FirebaseStorage
//
//struct ContentView: View {
//    @State private var image: UIImage?
//    @State private var showImagePicker = false
//    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @State private var showActionSheet = false
//    @State private var uploadProgress: Double = 0.0
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    @State private var isImagePickerPresented = false
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//            } else {
//                Rectangle()
//                    .fill(Color.gray)
//                    .frame(width: 300, height: 300)
//            }
//
//            Button(action: {
//                showActionSheet = true
//            }) {
//                Text("Select Photo")
//            }
//            .actionSheet(isPresented: $showActionSheet) {
//                ActionSheet(title: Text("Select Photo"), message: Text("Choose a photo source"), buttons: [
//                    .default(Text("Photo Library")) {
//                        sourceType = .photoLibrary
//                        showImagePicker = true
//                    },
//                    .default(Text("Camera")) {
//                        sourceType = .camera
//                        showImagePicker = true
//                    },
//                    .cancel()
//                ])
//            }
//
//            ProgressView(value: uploadProgress, total: 1.0)
//                .padding()
//            
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("Upload Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
//        }
//        .sheet(isPresented: $showImagePicker, onDismiss: handleImagePickerDismiss) {
//            NavigationView {
//                ImagePicker(image: $image, isPresented: $isImagePickerPresented, sourceType: sourceType)
//                    .navigationBarItems(trailing: Button("Bitti") {
//                        handleImagePickerDismiss()
//                    })
//            }
//        }
//    }
//
//    private func handleImagePickerDismiss() {
//        if let image = image {
//            uploadImage(image)
//        }
//    }
//
//    private func uploadImage(_ image: UIImage) {
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//            alertMessage = "Failed to get image data."
//            showAlert = true
//            return
//        }
//
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let photoRef = storageRef.child("images/\(UUID().uuidString).jpg")
//
//        let uploadTask = photoRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                print("Upload error: \(error.localizedDescription)")
//                alertMessage = "Upload failed: \(error.localizedDescription)"
//                showAlert = true
//                return
//            }
//            alertMessage = "Upload successful!"
//            showAlert = true
//        }
//
//        uploadTask.observe(.progress) { snapshot in
//            uploadProgress = Double(snapshot.progress?.fractionCompleted ?? 0)
//        }
//    }
//}
//
//
//
////#Preview {
////    FriendsPage()
////}
