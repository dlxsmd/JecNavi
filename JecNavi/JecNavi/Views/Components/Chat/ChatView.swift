import SwiftUI

struct ChatView: View {
    @ObservedObject var model = MessageModel()
    @ObservedObject var authentication = AuthenticationManager()
    var chatRoomID: String
    let otherMember: UserDataModel
    @Environment(\.dismiss) var dm

    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    LazyVStack{
                        ForEach(Array(model.messages.enumerated()), id: \.offset) { index, message in
                            let isLastMessage = message.id == model.messages.last?.id
                            messageView(for: message, previousMessage: index > 0 ? model.messages[index - 1] : nil, isLastMessage: isLastMessage) .id(message.id)
                        }
                    }
                    .onAppear {
                        print("ChatView appeared")
                        model.fetchMessages(chatRoomID: chatRoomID)
                        scrollView.scrollTo(model.messages.last?.id, anchor: .bottom)
                    }
                    .onChange(of: model.messages) {
                        scrollView.scrollTo(model.messages.last?.id, anchor: .bottom)
                    }
                }
            }
            .edgeSwipe()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            Spacer()
            SendFieldView(sendMessage: { message in
                // メッセージを送信し、Firestore の更新が完了するまで待機する
                model.sendMessage(chatRoomID: chatRoomID, message: message, author: authentication.userName)
                model.updateLastMessage(chatRoomID: chatRoomID, message: message, timestamp: Date())
            })
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dm()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text(otherMember.name)
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .padding()
    }
    
    private func messageView(for message: MessageDataModel, previousMessage: MessageDataModel?, isLastMessage: Bool) -> some View {
        VStack {
            if let previousMessage = previousMessage {
                if !Calendar.current.isDate(message.createdAt, inSameDayAs: previousMessage.createdAt) {
                    Text(message.createdAt, formatter:DateFormatter.shortDatewithWeek)
                        .font(.caption)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            } else {
                Text(message.createdAt, formatter:DateFormatter.shortDatewithWeek)
                    .font(.caption)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
            }
            ChatRowView(chatRoomID: chatRoomID, message: message, otherMember: otherMember, isMyMessage: message.author == authentication.userName, isLastMessage: isLastMessage)
        }
    }
}
