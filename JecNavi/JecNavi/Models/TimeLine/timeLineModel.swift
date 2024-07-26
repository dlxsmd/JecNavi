//
//  timeLineModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class timeLineModel:ObservableObject{
    @Published var posts:[timeLineDataModel] = []
    private var db = Firestore.firestore()
    
    func fetchPosts() {
            db.collection("timeLine")
            .order(by: "createdAt", descending: true)
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print("Error fetching documents: \(error)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    self.posts = documents.compactMap { document -> timeLineDataModel? in
                        try? document.data(as: timeLineDataModel.self)
                    }
                }
        }
        
        func addPost(post: String) {
            let newPost = timeLineDataModel(post: post, createdAt: Date())
            
            do {
                _ = try db.collection("timeLine").addDocument(from: newPost)
            } catch {
                print("Error adding post: \(error.localizedDescription)")
            }
        }
    }
