import SwiftUI
import YPImagePicker


enum ImagePickerType {
    case profile
    case post
    case story
    case reels
}

// YPImagePickerView: UIViewControllerRepresentable ile YPImagePicker'ı sarmalıyoruz.
struct YPImagePickerView: UIViewControllerRepresentable {
    
//    @State var selectedImage: UIImage?
//    @State var selectedVideo: URL?
    @Binding var Loading: Bool
    @Binding var selectedTab: Int
    
    var isRootPostPage = false
    var pickerType: ImagePickerType
    
    @ObservedObject private var viewModel = ProfileEdit_YPImageViewModel()
    @EnvironmentObject var globalClass: GlobalClass
    
    func makeUIViewController(context: Context) -> YPImagePicker {
        // YPImagePicker yapılandırması
        var config = YPImagePickerConfiguration()
       
        config.wordings.libraryTitle = "Galeri"
        config.wordings.cameraTitle = "Kamera"
        config.wordings.videoTitle = "Video"
        config.wordings.cancel = "İptal"
        config.wordings.next = "İleri"
        config.wordings.albumsTitle = "Albümler"
        config.wordings.save = "Kaydet"
        config.wordings.ok = "Tamam"
        config.wordings.filter = "Filtre"
        config.wordings.crop = "Kırp"
        
        
        if isRootPostPage {
            switch pickerType {
            case .profile:
                config.hidesBottomBar = true
            case .post:
                config.screens = [.library]
                config.library.mediaType = .photoAndVideo
                config.showsCrop = .rectangle(ratio: 1.0)
                config.hidesBottomBar = true
                
            case .story:
                config.screens = [.photo]
                config.library.mediaType = .photoAndVideo
                config.showsCrop = .rectangle(ratio: 1.0)
                config.hidesBottomBar = true
                
            case .reels:
                config.screens = [.video]
                config.library.mediaType = .photoAndVideo
                config.showsCrop = .rectangle(ratio: 1.0)
                config.hidesBottomBar = true
            }
            
        } else {
            switch pickerType {
            case .profile:
                config.screens = [.library, .photo]
                config.library.mediaType = .photo
                config.showsCrop = .circle
                
            case .post:
                config.screens = [.library]
                config.library.mediaType = .photoAndVideo
                config.showsCrop = .rectangle(ratio: 1.0)
                config.hidesBottomBar = true
                
            case .story:
                config.screens = [.library]
                config.library.mediaType = .photoAndVideo
                config.showsCrop = .rectangle(ratio: 1.0)
                config.hidesBottomBar = true
                
            case .reels:
                config.hidesBottomBar = true
            }
        }

        // 2. Library (Fotoğraf ve Video Kütüphanesi) Seçenekleri
        config.library.defaultMultipleSelection = false // Tek seçim yapılabilir
        config.library.maxNumberOfItems = 1 // Maksimum 1 foto/video seçilebilir
        
        // 3. Kamera Seçenekleri
        config.showsPhotoFilters = true // Çekilen fotoğraflar için filtre seçeneği
         // Fotoğraf kırpma oranı (1:1)
        
        // 4. Video Seçenekleri
        config.video.fileType = .mp4 // Video formatı
        //  config.video.compression = AVAssetExportPresetMediumQuality // Video sıkıştırma kalitesi
        config.video.recordingTimeLimit = 60.0 // Maksimum video kayıt süresi (60 saniye)
        config.showsVideoTrimmer = true // Video kırpma (trimming) seçeneği
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                switch pickerType {
                case .profile:
                    picker.dismiss(animated: true, completion: nil)
                    
                case .post:
                    if isRootPostPage {
                        picker.dismiss(animated: true) {
                            selectedTab = 0
                        }
                    } else {
                        picker.dismiss(animated: true)
                    }
                    
                    
                case .story:
                    if isRootPostPage {
                        picker.dismiss(animated: true) {
                            selectedTab = 0
                        }
                    } else {
                        picker.dismiss(animated: true)
                    }
                    
                case .reels:
                    if isRootPostPage {
                        picker.dismiss(animated: true) {
                            selectedTab = 0
                        }
                    } else {
                        picker.dismiss(animated: true)
                    }
                }
                
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            if let photo = items.singlePhoto {
       
                switch pickerType {
                case .profile:
                    profileImagePicker(image:  photo.image, picker: picker)
                case .post:
                    postImagePicker(image:  photo.image, picker: picker)
                case .story:
                    storyImagePicker(image:  photo.image, picker: picker)
                case .reels:
                    print("reels")
                }
            }
            
            if let video = items.singleVideo {
                print(video.url)
            }
            
           
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: YPImagePicker, context: Context) {
        // Gerekli güncellemeler burada yapılabilir.
    }
    
    // MARK: - Funcs
    
    private func profileImagePicker(image: UIImage, picker: YPImagePicker) {
        if let user = globalClass.User {
            Loading = true
            if user.profilePhoto != nil {
                print("silinen foto:  \(user.profilePhoto?.id ?? "")")
                viewModel.deleteImage(imagePath: user.profilePhoto?.id ?? "") { isDeleted in
                    print("silindi: \(isDeleted)")
                }
            }
            
            viewModel.uploadProfileImage(id: user.id ?? "", image: image) { isAdded in
                if isAdded {
                    viewModel.getUserInfos(id: user.id ?? "") { result in
                        switch result {
                        case .success(let user):
                            globalClass.User = user
                            Loading = false
                            picker.dismiss(animated: true, completion: nil)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
        }
    }
    
    private func postImagePicker(image: UIImage, picker: YPImagePicker) {
        if let user = globalClass.User {
            Loading = true
            
            viewModel.uploadPostImage(id: user.id ?? "", image: image, oldPostIDs: user.postIDs) { isAdded in
                if isAdded {
                    viewModel.getUserInfos(id: user.id ?? "") { result in
                        switch result {
                        case .success(let user):
                            globalClass.User = user
                            Loading = false
                            if isRootPostPage {
                                picker.dismiss(animated: true) {
                                    selectedTab = 0
                                }
                            } else {
                                picker.dismiss(animated: true)
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    private func storyImagePicker(image: UIImage, picker: YPImagePicker) {
        if let user = globalClass.User {
            Loading = true
            
            viewModel.uploadStoryImage(userId: user.id ?? "", image: image) { isAdded in
                if isAdded {
                    viewModel.getUserInfos(id: user.id ?? "") { result in
                        switch result {
                        case .success(let user):
                            globalClass.User = user
                            Loading = false
                            if isRootPostPage {
                                picker.dismiss(animated: true) {
                                    selectedTab = 0
                                }
                            } else {
                                picker.dismiss(animated: true)
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
            }
        }
    }
    
}
