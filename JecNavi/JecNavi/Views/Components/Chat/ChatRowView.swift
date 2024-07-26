//
//  ChatRowView.swift
// 個人チャットのメッセージ一つ一つを表示するためのView
//  JecNavi
//
//  Created by yuki on 2024/06/18.
//

import SwiftUI
import FirebaseAuth

struct ChatRowView: View {
    @ObservedObject var model = MessageModel()
    @ObservedObject var network = NetworkStatus()
    let chatRoomID: String
    let message: MessageDataModel
    let otherMember: UserDataModel
    let isMyMessage: Bool
    let isLastMessage: Bool
    var currentUserID : String?{
        Auth.auth().currentUser?.uid
    }

    var body: some View {
        if isMyMessage {
            HStack {
                Spacer()
                HStack {
                    VStack(alignment: .trailing){
                         if isLastMessage{
                             if message.readBy.contains(otherMember.id!) {
                               Text("既読")
                                    .font(.system(size: 7.5))
                             } else if !network.isConnected{
                                Text("送信エラー")
                                     .foregroundColor(.red)
                                    .font(.system(size: 7.5))
                             }else{
                                 Text("送信済み")
                                     .font(.system(size: 7.5))
                             }
                         }
                        Text("\(message.createdAt, formatter: DateFormatter.shortTime)")
                    }
                    .foregroundColor(.gray)
                        .font(.caption2)
                    if let attributedString = createAttributedString(from: message.message, isMyMessage: true) {
                        Text(attributedString)
                            .textSelection(.enabled)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.blue)
                            .cornerRadius(20)
                    } else {
                        Text(message.message)
                            .textSelection(.enabled)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
            }
        } else {
            HStack {
                HStack {
                    if let attributedString = createAttributedString(from: message.message, isMyMessage: false) {
                        Text(attributedString)
                            .textSelection(.enabled)
                            .foregroundColor(.black)
                            .padding(15)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                    } else {
                        Text(message.message)
                            .textSelection(.enabled)
                            .foregroundColor(.black)
                            .padding(15)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                    }
                    Text("\(message.createdAt, formatter: DateFormatter.shortTime)")
                        .font(.caption)
                }
                Spacer()
            }.onAppear(){
                model.markMessageAsRead(chatRoomID: chatRoomID, messageID: message.id!, userID: currentUserID!)
            }
        }
    }
    
    func createAttributedString(from message: String, isMyMessage: Bool) -> AttributedString? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: message, options: [], range: NSRange(location: 0, length: message.utf16.count))
        
        var attributedString = AttributedString(message)
        
        for match in matches {
            if let range = Range(match.range, in: message), let url = match.url {
                if let attributedRange = Range(range, in: attributedString) {
                    attributedString[attributedRange].link = url
                    if isMyMessage {
                        attributedString[attributedRange].foregroundColor = .white
                    } else {
                        attributedString[attributedRange].foregroundColor = .blue
                    }
                    attributedString[attributedRange].underlineStyle = .single
                }
            }
        }
        
        return attributedString
    }
}
