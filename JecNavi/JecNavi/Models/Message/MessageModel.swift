import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageModel: ObservableObject {
    @Published var messages: [MessageDataModel] = []
    private var db = Firestore.firestore()
    
    func fetchMessages(chatRoomID: String) {
        db.collection("ChatRooms").document(chatRoomID).collection("Messages")
            .order(by: "createdAt")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    print("fetchMessages")
                    self.messages = querySnapshot?.documents.compactMap { document in
                        try? document.data(as: MessageDataModel.self)
                    } ?? []
                }
            }
    }
    
    func sendMessage(chatRoomID: String, message: String, author: String) {
        let messageData = MessageDataModel(author: author, message: message, createdAt: Date())
        
        do {
            try! db.collection("ChatRooms").document(chatRoomID).collection("Messages").addDocument(from: messageData)
            { error in
                if let error = error {
                    print("Error sending message: \(error)")
                } 
            }
        }
    }
    // lastMessageとtimestampを更新
    func updateLastMessage(chatRoomID: String, message: String, timestamp: Date) {
        db.collection("ChatRooms").document(chatRoomID).collection("Recent").document("lastMessageInfo").setData([
            "lastMessage": message,
            "lastMessageTimestamp": timestamp
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    func markMessageAsRead(chatRoomID: String, messageID: String,userID: String) {
        db.collection("ChatRooms").document(chatRoomID).collection("Messages").document(messageID).updateData([
            "readBy": FieldValue.arrayUnion([userID])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

