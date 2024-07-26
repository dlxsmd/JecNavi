//
//  ChatDataModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/18.
//

import Foundation
import FirebaseFirestoreSwift

struct MessageDataModel: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var author: String
    var message: String
    var createdAt: Date
    var readBy: [String] // 既読したユーザーのIDを保持する配列
    
    // 初期化
    init(id: String? = nil, author: String, message: String, createdAt: Date, readBy: [String] = []) {
        self.id = id
        self.author = author
        self.message = message
        self.createdAt = createdAt
        self.readBy = readBy
    }
}


