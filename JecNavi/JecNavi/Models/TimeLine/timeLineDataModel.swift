//
//  timeLineDataModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/26.
//

import Foundation
import FirebaseFirestoreSwift

struct timeLineDataModel: Identifiable,Codable,Equatable {
    @DocumentID var id: String?
    var post: String
    var createdAt: Date
}
