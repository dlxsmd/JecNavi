//
//  ChatRoomsRowVIew.swift
//  JecNavi
//
//  Created by yuki on 2024/06/19.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ChatRoomsRowView: View {
    let chatRoom: ChatRoomsDataModel
    let otherMember: UserDataModel
    @State private var showChatView = false
    @State private var selectedChatRoomID: String?
    
    @State private var lastMessage: String = ""
    @State private var lastMessageTimestamp: Date = Date()
    @State private var listener: ListenerRegistration?

    var body: some View {
        NavigationLink(destination: ChatView(chatRoomID: chatRoom.id!, otherMember: otherMember)) {
            HStack {
                if let photoURL = otherMember.profilePictureURL {
                    AsyncImage(url: URL(string: photoURL)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading) {
                    Text(otherMember.name)
                        .foregroundColor(.black)
                        .font(.headline)
                    Text(lastMessage)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack {
                    if !Calendar.current.isDateInToday(lastMessageTimestamp) {
                        Text("\(lastMessageTimestamp, formatter: DateFormatter.shortDate)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                        Text("\(lastMessageTimestamp, formatter: DateFormatter.shortTime)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
            }
        }
        .onAppear {
            fetchLastMessage()
        }
        .onDisappear {
            listener?.remove()
            showChatView = false
        }
        .onTapGesture {
            selectedChatRoomID = chatRoom.id
            print(selectedChatRoomID ?? "No Chat Room ID")
            showChatView = true
        }
    }

    private func fetchLastMessage() {
        listener = ChatRoomsModel.shared.fetchRecentMessage(chatRoomID: chatRoom.id ?? "") { message, timestamp in
            self.lastMessage = message
            self.lastMessageTimestamp = timestamp
        }
    }
}

