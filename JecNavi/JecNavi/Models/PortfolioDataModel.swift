//
//  PortfolioRequestDataModel.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/24.
//

import Foundation
import FirebaseFirestoreSwift


struct PortfolioDataModel: Identifiable, Codable, Equatable{
 @DocumentID var id: String?
 let productName: String
 let creatorName: String
 let creatorClass: String
 let description: String
 let uiImages: [String]
 var isPublished: Bool
}
 
