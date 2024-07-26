//
//  ChatRoomsModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/19.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class ChatRoomsModel: ObservableObject {
    static let shared = ChatRoomsModel()
    @Published var chatRooms: [ChatRoomsDataModel] = []
    @Published var users: [String: UserDataModel] = [:]
    private var db = Firestore.firestore()
    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    private init() {
        fetchChatRooms()
    }
    
    func fetchChatRooms() {
        guard let currentUserID = currentUserID else {
            return
        }
        print(currentUserID)
        db.collection("ChatRooms")
            .whereField("members", arrayContains: currentUserID)
            .order(by: "lastMessageTimestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    print(currentUserID)
                    self.chatRooms = querySnapshot?.documents.compactMap { document in
                        try? document.data(as: ChatRoomsDataModel.self)
                    } ?? []
                    
                    // Fetch user info for each chat room
                    self.chatRooms.forEach { chatRoom in
                        chatRoom.members.forEach { memberID in
                            if memberID != currentUserID {
                                self.fetchUser(userID: memberID)
                            }
                        }
                    }
                }
            }
    }
    
    func fetchUser(userID: String) {
        db.collection("Users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                if let user = try? document.data(as: UserDataModel.self) {
                    DispatchQueue.main.async {
                        self.users[userID] = user
                    }
                }
            }
        }
    }
    func createChatRoom(otherUserID: String) {
           guard let currentUserID = currentUserID else {
               return
           }
           let chatRoom = ChatRoomsDataModel(members: [currentUserID, otherUserID], lastMessageTimestamp: Date())
           
           do {
               let chatRoomRef = try db.collection("ChatRooms").addDocument(from: chatRoom)
               
               // Create the recent message document in the recent collection
               chatRoomRef.collection("Recent").document("lastMessageInfo").setData([
                   "lastMessage": "",
                   "lastMessageTimestamp": FieldValue.serverTimestamp()
               ]) { error in
                   if let error = error {
                       print("Error creating recent message document: \(error)")
                   }
               }
               
           } catch {
               print("Error creating chat room: \(error)")
           }
       }
    func chatRoomExists(otherUserID: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserID = currentUserID else {
            completion(false)
            return
        }
        
        db.collection("ChatRooms")
            .whereField("members", arrayContains: currentUserID)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("ドキュメントの取得エラー: \(error)")
                    completion(false)
                } else {
                    if let documents = querySnapshot?.documents {
                        for document in documents {
                            if let chatRoom = try? document.data(as: ChatRoomsDataModel.self),
                               chatRoom.members.contains(otherUserID) {
                                completion(true)
                                return
                            }
                        }
                    }
                    completion(false)
                }
            }
    }
    func fetchRecentMessage(chatRoomID: String, completion: @escaping (String, Date) -> Void) -> ListenerRegistration? {
        let listener = db.collection("ChatRooms").document(chatRoomID).collection("Recent").document("lastMessageInfo").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot, document.exists, let data = document.data() else {
                completion("", Date())
                return
            }
            let lastMessage = data["lastMessage"] as? String ?? ""
            let lastMessageTimestamp = (data["lastMessageTimestamp"] as? Timestamp)?.dateValue() ?? Date()
            completion(lastMessage, lastMessageTimestamp)
        }
        return listener
    }

}
