//
//  PortFolioRequestModel.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class PortfolioModel: ObservableObject{
    
    @Published var requests: [PortfolioDataModel] = []
    private var db = Firestore.firestore()
    
    func fetchRequests() {
        db.collection("Portfolio")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.requests = documents.compactMap { document -> PortfolioDataModel? in
                    try? document.data(as: PortfolioDataModel.self)
                }
            }
    }
    
    func loadImages(urls: [String], completion: @escaping ([UIImage]) -> Void) {
        let storage = Storage.storage()
        var images: [UIImage] = []
        var downloadCount = 0
        
        guard urls.count > 0 else {
            completion([])
            return
        }
        
        for url in urls {
            let storageRef = storage.reference(forURL: url)
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else { return }
                images.append(image)
                downloadCount += 1
                
                if downloadCount == urls.count {
                    completion(images)
                }
            }
        }
    }
    
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: url)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
    }
    
    func addRequest(request: PortfolioDataModel) {
        
        do {
            try! db.collection("Portfolio").addDocument(from: request)
            { error in
                if let error = error {
                    print("Error sending message: \(error)")
                }
            }
        }
    }
    func UploadImage(uiImages: [UIImage?], completion: @escaping (Result<[String], Error>) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        var urls: [String] = []
        var uploadCount = 0
        let totalUploads = uiImages.compactMap { $0 }.count
        
        guard totalUploads > 0 else {
            completion(.failure(NSError(domain: "UploadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No valid images to upload."])))
            return
        }
        
        for uiImage in uiImages {
            guard let image = uiImage else { continue }
            let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { continue }
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            _ = imageRef.putData(imageData, metadata: metadata) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                imageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error fetching download URL: \(error)")
                        return
                    }
                    
                    guard let url = url else { return }
                    urls.append(url.absoluteString)
                    uploadCount += 1
                    
                    if uploadCount == totalUploads {
                        completion(.success(urls))
                    }
                }
            }
        }
    }
}
