import SwiftUI
import FirebaseAuth

struct ChatRoomsView: View {
    @ObservedObject var authentication = AuthenticationManager()
    @ObservedObject var model = ChatRoomsModel.shared
    @State var showChatView:Bool = false
    @State var isreadQr:Bool = false
    @State var searchText:String = ""
    @State var isShowLogin = false
    
    var body: some View {
        NavigationStack {
            HeaderView()
            HStack{
                Text("Chat")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Spacer()
            }
            if authentication.isSignIn {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        SearchBar(text: $searchText, searchAction: { _ in })
                            .padding(.vertical,10)
                        ForEach(filteredChatRooms) { chatRoom in
                            if let currentUserID = Auth.auth().currentUser?.uid,
                               let otherMemberID = chatRoom.members.first(where: { $0 != currentUserID }),
                               let otherMember = model.users[otherMemberID] {
                                ChatRoomsRowView(chatRoom: chatRoom, otherMember: otherMember)
                            }
                        }
                        .padding(10)
                    }
                    .animation(.easeInOut(duration: 0.3),value: filteredChatRooms.count)
                    HStack{
                        
                        Spacer()
                        Button {
                            isreadQr.toggle()
                        } label: {
                            ZStack {
                                Circle().foregroundColor(.green)
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 5)
                                Image(systemName: "qrcode.viewfinder")
                                    .foregroundColor(.white)
                                    .scaleEffect(2)
                            }
                        }
                        .padding()
                        .padding(.bottom, 70)
                    }
                }
            }else{
                Spacer()
                VStack{
                    Text("Please sign in School Google Account to use the chat feature.")
                        .padding()
                    Button(action: {
                        isShowLogin.toggle()
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    })
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isreadQr) {
            QrView(isreadQr: $isreadQr)
        }
        .onAppear {
            model.fetchChatRooms()
        }
        .onChange(of: authentication.isSignIn) {
            if authentication.isSignIn {
                model.fetchChatRooms()
            }
        }
        .sheet(isPresented: $isShowLogin) {
            SignInView()
        }
    }
    
    var filteredChatRooms: [ChatRoomsDataModel] {
        if searchText.isEmpty {
            return model.chatRooms
        } else {
            return model.chatRooms.filter { chatRoom in
                if let currentUserID = Auth.auth().currentUser?.uid,
                   let otherMemberID = chatRoom.members.first(where: { $0 != currentUserID }),
                   let otherMember = model.users[otherMemberID] {
                    return otherMember.name.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        }
    }
}

#Preview {
    ChatRoomsView()
}
