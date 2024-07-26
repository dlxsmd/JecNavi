//
//  ChatRoomsDataModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/19.
//
import Foundation
import FirebaseFirestoreSwift

struct ChatRoomsDataModel: Identifiable, Codable {
    @DocumentID var id: String?
    var members: [String]
    var lastMessageTimestamp: Date
}
