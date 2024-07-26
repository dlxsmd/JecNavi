//
//  UserDataModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/19.
//

import Foundation
import FirebaseFirestoreSwift

struct UserDataModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var profilePictureURL: String?
}
