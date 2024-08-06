//
//  DeletingUnnecessaryImageInStorage.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 1.08.2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class DeleteStorageViewModel: ObservableObject {
    
    // MARK: - BU ViewModel Storage da kalan gereksiz fotoğrafları manuel olarak silmek için yapıldı
    
    func syncFirestoreAndStorage() {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference().child("ProfileImages")
        
        // Firestore'daki image ID'lerini alın
        db.collection("ProfileImages").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var firestoreImageIds: Set<String> = []
                for document in querySnapshot!.documents {
                    firestoreImageIds.insert(String(document.documentID))
                }
                
                // Storage'daki dosyaları alın
                storageRef.listAll { (result, error) in
                    if let error = error {
                        print("Error listing files: \(error)")
                    } else {
                        if let items = result?.items {
                            for item in items {
                                let fileName = item.name
                                if !(firestoreImageIds.contains(String(fileName))) {
                                    // Firestore'da olmayan dosyaları silin
                                    item.delete { error in
                                        if let error = error {
                                            print("Error deleting file: \(error)")
                                        } else {
                                            print("File \(fileName) deleted")
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
}
