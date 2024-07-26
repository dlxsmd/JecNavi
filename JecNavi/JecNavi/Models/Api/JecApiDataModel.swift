//
//  JecApiDataModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/17.
//

import Foundation

struct importantData:Codable{
    let date:String
    let link:String
    let title:String
}

struct newsData:Codable{
    let date:String
    let link:String
    let title:String
    let image:String
}
